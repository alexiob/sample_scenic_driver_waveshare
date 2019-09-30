# Sample for scenic_driver_waveshare

A sample application for using the [Scenic Driver](https://github.com/alexiob/scenic_driver_waveshare) for the [128x128, 1.44inch LCD display HAT for Raspberry Pi from Waveshare](https://www.waveshare.com/product/modules/oleds-lcds/raspberry-pi-lcd/1.44inch-lcd-hat.htm).

## Getting it running on the host

You have to run this with no-halt in dev or it will just blink past and close down.

```sh
export MIX_ENV=host
mix deps.get
mix run --no-halt
```

## Getting it onto hardware

To start your Nerves app:
  * `export MIX_TARGET=<TARGET>` or prefix every command with
    `MIX_TARGET=<TARGET>`. For example, `MIX_TARGET=rpi0`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`
  * Any subsequent updates can use `mix firmware.gen.script` and `./upload.sh` (already provided in the repo)

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
  *