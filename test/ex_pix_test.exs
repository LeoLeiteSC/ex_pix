defmodule ExPIXTest do
  use ExUnit.Case
  doctest ExPIX

  alias ExPIX.Data.Static

  setup [:build_params]

  describe "when parameters are correct" do
    test "should build a code if the parameters are correct", %{static_params: static_params} do
      assert {:ok, received_string} = ExPIX.generate_static_code("random_key", static_params)

      assert is_binary(received_string)
    end
  end

  describe "when parameters are incorrect" do
    test "should return an error if a parameter is incorrect", %{static_params: static_params} do
      name_limit = Static.max_lengths().merchant_name
      new_params = Map.replace!(static_params, :merchant_name, String.pad_leading("a", name_limit + 1, "a"))

      assert {:error, "The merchant_name is invalid"} == ExPIX.generate_static_code("random_key", new_params)
    end
  end

  defp build_params(_) do
    [static_params: %{merchant_name: "Name", merchant_city: "City"}]
  end
end
