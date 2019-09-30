use Mix.Config

config :sample_scenic_driver_waveshare, :viewport, %{
  name: :main_viewport,
  default_scene: {SampleScenicDriverWaveshare.Scene.Main, nil},
  # Match these to your display
  size: {128, 128},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: Scenic.Driver.Glfw,
      name: :waveshare
    }
  ]
}
