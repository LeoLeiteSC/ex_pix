# ExPIX

Dependency created especially to generate QR-Codes for PIX payments.

PIX is a payment solution created by the Brazilian bank Banco Central.

This dependency follow some style guidelines that can be seen here:
  - https://github.com/christopheradams/elixir_style_guide
  - https://github.com/jungsoft/elixir-style-guide

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_pix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_pix, "~> 0.1.0"}
  ]
end
```

## Usage

For now, this library is only generating the code for static QR-Codes. This operation can be done using the `ExPIX.generate_static_code` function.

Besides that, this library is using a default configuration for Brazil marketplace:

```elixir
config :ex_pix, :static_code,
  payload_indicator: "01",
  initiation_method: "11",
  gui: "br.gov.bcb.pix",
  currency_code: "986",
  country_code: "BR",
  default_amount: "0.00",
  category_code: "0000"
```

If you need to change any of these fields, you can replace this configuration in your own configuration file.
