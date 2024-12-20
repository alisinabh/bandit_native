defmodule BanditNative.MixProject do
  use Mix.Project

  def project do
    [
      app: :bandit_native,
      version: "0.0.1",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib/", "test/support"]
  defp elixirc_paths(_), do: ["lib/"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, ">= 1.6.0"},
      {:rustler, ">= 0.0.0", runtime: false}
    ]
  end
end
