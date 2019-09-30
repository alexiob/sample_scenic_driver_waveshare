defmodule SampleScenicDriverWaveshare.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Waveshare.Supervisor]

    main_viewport_config = Application.get_env(:sample_scenic_driver_waveshare, :viewport)

    children =
      [
        # Children for all targets
        {Scenic, viewports: [main_viewport_config]}
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    []
  end

  def children(_target) do
    []
  end

  def target() do
    Application.get_env(:sample_scenic_driver_waveshare, :target)
  end
end
