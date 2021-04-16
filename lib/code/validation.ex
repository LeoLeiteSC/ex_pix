defmodule ExPIX.Code.Validation do
  @moduledoc """
  Module with basic validations
  """

  alias ExPIX.Data.{
    Additional,
    Static,
    StaticAccount,
  }
  alias ExPIX.Code.Helpers

  def validate_field(:account_information, %StaticAccount{} = value) do
    struct_length = Helpers.total_struct_length(value)

    validate(StaticAccount.total_length(), struct_length)
  end

  def validate_field(:additional, %Additional{} = value) do
    struct_length = Helpers.total_struct_length(value)

    validate(Additional.total_length(), struct_length)
  end

  def validate_field(field, value) do
    Static.max_lengths()
    |> Map.get(field)
    |> validate(String.length(value))
  end

  defp validate(nil, _field_length), do: true
  defp validate(limit, field_length), do: field_length <= limit
end
