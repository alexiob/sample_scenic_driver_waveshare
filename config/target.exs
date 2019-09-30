use Mix.Config

# Authorize the device to receive firmware using your public key.
# See https://hexdocs.pm/nerves_firmware_ssh/readme.html for more information
# on configuring nerves_firmware_ssh.

keys =
  [
    Path.join([System.user_home!(), ".ssh", "nerves.pub"])
  ]
  |> Enum.filter(&File.exists?/1)

if keys == [],
  do:
    Mix.raise("""
    No SSH public keys found in ~/.ssh. An ssh authorized key is needed to
    log into the Nerves device and update firmware on it using ssh.
    See your project's config.exs for this error message.
    """)

config :nerves_firmware_ssh,
  authorized_keys: Enum.map(keys, &File.read!/1)

# Configure nerves_init_gadget.
# See https://hexdocs.pm/nerves_init_gadget/readme.html for more information.

# Setting the node_name will enable Erlang Distribution.
# Only enable this for prod if you understand the risks.
node_name = if Mix.env() != :prod, do: "sample_waveshare"

config :nerves_init_gadget,
  ifname: "eth0",
  address_method: :dhcp,
  mdns_domain: "nerves.local",
  node_name: node_name,
  node_host: :mdns_domain

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.target()}.exs"

config :sample_scenic_driver_waveshare, :viewport, %{
  name: :main_viewport,
  default_scene: {SampleScenicDriverWaveshare.Scene.Main, nil},
  # Match these to your display
  size: {128, 128},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: Scenic.Driver.Nerves.Waveshare,
      opts: [
        device_sku: :sku138191,
        # :color18bit (default) | :color16bit | :color12bit
        color_depth: :color18bit,
        # :rgb | :bgr (default)
        color_order: :bgr,
        # :l2r_u2d | :l2r_d2u | :r2l_u2d | :r2l_d2u | :u2d_l2r | :u2d_r2l (default) | :d2u_l2r | :d2u_r2l
        scan_dir: :u2d_r2l,
        # :ppm | :rgb24 (default) | :rgb565 | :mono | :mono_column_scan
        capture_format: :rgb24,
        refresh_interval: 50,
        spi_speed_hz: 40_000_000
      ],
      name: :waveshare
    }
  ]
}
