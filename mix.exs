defmodule Grimoire.MixProject do
  use Mix.Project

  def project do
    [
      app: :grimoire,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/vfsoraki/grimoire"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  defp description() do
    "Supercharged Elixir structs"
  end

  defp package() do
    [
      # These are the default files included in the package
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/vfsoraki/grimoire"}
    ]
  end
end
