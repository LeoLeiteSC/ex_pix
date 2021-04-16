defmodule ExPIX do
  @moduledoc """
  Documentation for `ExPIX`.
  """

  alias ExPIX.Data.{
    Additional,
    Static,
    StaticAccount,
  }
  alias ExPIX.Code.Builder

  @type static_params :: %{
    required(:merchant_name) => String.t,
    required(:merchant_city) => String.t,
    optional(:amount) => String.t,
    optional(:payload_indicator) => String.t,
    optional(:initiation_method) => String.t,
    optional(:category_code) => String.t,
    optional(:currency_code) => String.t,
    optional(:country_code) => String.t,
    optional(:postal_code) => String.t,
  }

  @type account_params :: %{optional(:info) => String.t}
  @type additional_params :: %{optional(:txid) => String.t}

  @spec generate_static_code(String.t(), static_params, account_params, additional_params) :: {:ok, String.t()} | {:error, any}
  def generate_static_code(key, static_params, account_params \\ %{}, additional_params \\ %{}) do
    account_info = Map.merge(%StaticAccount{}, Map.merge(%{key: key}, account_params))
    additional_info = Map.merge(%Additional{}, additional_params)
    final_params = static_params |> Map.put(:account_information, account_info) |> Map.put(:additional, additional_info)

    %Static{}
    |> Map.merge(final_params)
    |> Builder.build()
  end
end
