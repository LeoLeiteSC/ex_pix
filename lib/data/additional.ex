defmodule ExPIX.Data.Additional do
  @moduledoc """
  Struct representing the additional information
  """

  defstruct [
    txid: "***",
  ]

  def ids do
    [
      {"05", :txid},
    ]
  end

  def max_lengths do
    %{
      txid: nil,
    }
  end

  def total_length, do: 99
end
