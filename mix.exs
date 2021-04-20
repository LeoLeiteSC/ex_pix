defmodule ExPIX.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_pix,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ExPIX",
      source_url: "https://github.com/LeoLeiteSC/ex_pix",
      description: "Elixir library to deal with PIX payments",
      package: package(),
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/LeoLeiteSC/ex_pix",
        "Docs" => "https://hexdocs.pm/ex_pix/"
      }
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # Documentation
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      # QR-Codes
      {:eqrcode, "~> 0.1.7"},
      {:crc, "~> 0.10.1"},
    ]
  end
end
