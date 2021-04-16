defmodule ExPIX.Code.Builder do
  @moduledoc """
  Functions to build the string code
  """

  alias ExPIX.Data.{
    Additional,
    Static,
    StaticAccount,
  }
  alias ExPIX.Code.{
    Helpers,
    Validation,
  }

  def build(%Static{} = info) do
    Static.ids()
    |> Enum.reduce_while({:ok, ""}, & do_build(&1, &2, info))
    |> case do
      {:error, _reason} = error -> error
      {:ok, string_code} -> {:ok, add_crc(string_code)}
    end
  end

  defp do_build({id, field}, previous_string, info) do
    value = Map.get(info, field, "")

    with  true <- Validation.validate_field(field, value),
          {:ok, new_code} <- build_reduce(id, previous_string, value)
    do
      {:cont, {:ok, new_code}}
    else
      false -> {:halt, {:error, "The #{Atom.to_string(field)} is invalid"}}
      {:error, _reason} = error -> {:halt, error}
    end
  end

  defp build_reduce("26" = id, {:ok, previous_string}, account_info_value) do
    build_secondary_struct(StaticAccount.ids(), id, previous_string, account_info_value)
  end

  defp build_reduce("62" = id, {:ok, previous_string}, additional_info_value) do
    build_secondary_struct(Additional.ids(), id, previous_string, additional_info_value)
  end

  defp build_reduce(id, {:ok, previous_string}, value) do
    Helpers.build_new_line(id, previous_string, value, Helpers.build_length(value))
  end

  defp build_secondary_struct(ids, struct_id, previous_string, info) do
    ids
    |> Enum.reduce_while({:ok, ""}, & do_build(&1, &2, info))
    |> case do
      {:ok, value} ->
        Helpers.build_new_line(struct_id, previous_string, value, Helpers.build_total_struct_length(info))

      {:error, _reason} = error ->
        error
    end
  end

  defp add_crc(string) do
    without_crc = string <> "6304"

    without_crc <> (without_crc |> CRC.ccitt_16() |> Integer.to_string(16))
  end
end
