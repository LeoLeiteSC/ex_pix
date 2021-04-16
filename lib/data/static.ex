defmodule ExPIXQR.Data.Static do
  @moduledoc """
  Struct representing the static data
  """

  alias ExPIXQR.Data.{
    StaticAccount,
    Additional,
  }

  defstruct [
    payload_indicator: Application.get_env(:ex_pixqr, :static)[:payload_indicator],
    initiation_method: Application.get_env(:ex_pixqr, :static)[:initiation_method],
    account_information: %StaticAccount{},
    category_code: "0000",
    currency_code: Application.get_env(:ex_pixqr, :static)[:currency_code],
    amount: "0.00",
    country_code: Application.get_env(:ex_pixqr, :static)[:country_code],
    merchant_name: "",
    merchant_city: "",
    postal_code: "",
    additional: %Additional{},
  ]

  def ids do
    [
      {"00", :payload_indicator},
      {"01", :initiation_method},
      {"26", :account_information},
      {"52", :category_code},
      {"53", :currency_code},
      {"54", :amount},
      {"58", :country_code},
      {"59", :merchant_name},
      {"60", :merchant_city},
      {"61", :postal_code},
      {"62", :additional},
    ]
  end

  def max_lengths do
    %{
      payload_indicator: 2,
      initiation_method: 2,
      category_code: 4,
      currency_code: 3,
      amount: 13,
      country_code: 2,
      merchant_name: 25,
      merchant_city: 15,
      postal_code: 99,
    }
  end

  def total_length, do: nil
end
