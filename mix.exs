defmodule Objects.Mixfile do
  use Mix.Project

  def project do
    [app: :objects,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Objects, []},
      applications: [
        :phoenix,
        :phoenix_pubsub,
        :phoenix_html,
        :cowboy,
        :logger,
        :gettext,
        :poolboy,
        :httpoison
     ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.0-rc"},
      {:phoenix_pubsub, "~> 1.0.0-rc"},
      {:phoenix_html, "~> 2.4"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:poison, "~> 2.1"},
      {:poolboy, "~> 1.5"},
      {:floki, "~> 0.8"},
      {:httpoison, "~> 0.8"},
    ]
  end
end
