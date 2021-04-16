defmodule ExPIX.Data.StaticAccount do
  @moduledoc """
  Struct representing the merchant account information
  """

  defstruct [
    gui: Application.get_env(:ex_pix, :static_code)[:gui],
    key: "",
    info: "",
  ]

  def ids do
    [
      {"00", :gui},
      {"01", :key},
      {"02", :info},
    ]
  end

  def max_lengths do
    %{
      gui: 14,
      key: nil,
      info: nil,
    }
  end

  def total_length, do: 99
end
