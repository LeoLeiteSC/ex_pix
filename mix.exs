defmodule ExPIXQR.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_pixqr,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:eqrcode, "~> 0.1.7"},
    ]
  end
end
