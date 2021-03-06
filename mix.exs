defmodule Astarte.Pairing.Mixfile do
  use Mix.Project

  def project do
    [
      app: :astarte_pairing,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      deps: deps() ++ astarte_required_modules(System.get_env("ASTARTE_IN_UMBRELLA"))
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Astarte.Pairing, []},
      extra_applications: [:logger]
    ]
  end

  defp astarte_required_modules("true") do
    [
      {:astarte_rpc, in_umbrella: true},
      {:astarte_data_access, in_umbrella: true}
    ]
  end
  defp astarte_required_modules(_) do
    [
      {:astarte_rpc, git: "https://git.ispirata.com/Astarte-NG/astarte_rpc"},
      {:astarte_data_access, git: "https://git.ispirata.com/Astarte-NG/astarte_data_access"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cqex, github: "ispirata/cqex"},
      {:plug, "~> 1.4.0"},
      {:uuid, "~> 1.7", hex: :uuid_erl},
      {:cfxxl, "~> 0.3.0"},
      {:conform, "~> 2.2"},

      {:excoveralls, "~> 0.7.3", only: :test},
      {:distillery, "~> 1.5", runtime: false}
    ]
  end
end
