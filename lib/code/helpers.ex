defmodule ExPIXQR.Code.Helpers do
  @moduledoc """
  Module with helper functions
  """

  def build_length(value) when is_binary(value), do: value |> String.length() |> build_length()
  def build_length(value) when is_integer(value), do: value |> Integer.to_string() |> String.pad_leading(2, "0")

  def total_struct_length(struct) when is_struct(struct) do
    valid_fields = struct |> Map.from_struct() |> Enum.reject(fn {_, field} -> field == "" end) |> Map.new()
    fields_count = Enum.count(valid_fields)

    valid_fields
    |> Map.values()
    |> Enum.join()
    |> String.length()
    |> Kernel.+(fields_count * 4)
  end

  def build_total_struct_length(struct) when is_struct(struct) do
    struct
    |> total_struct_length()
    |> build_length()
  end

  def build_new_line(_id, previous_string, "", _length), do: {:ok, previous_string}

  def build_new_line(id, previous_string, value, length) do
    {:ok, previous_string <> "#{id}#{length}#{value}"}
  end
end
