defmodule C3P0.MixProject do
  use Mix.Project

  @version "0.2.1"

  def project do
    [
      app: :c3p0,
      version: @version,
      elixir: "~> 1.9",
      description: description(),
      consolidate_protocols: Mix.env() != :test,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      docs: [
        canonical: "https://hexdocs.pm/c3p0",
        extras: ["README.md"],
        source_ref: "v#{@version}",
        source_url: "https://github.com/hassox/c3p0"
      ],
      package: [
        files: [
          ".formatter.exs",
          "mix.exs",
          "README.md",
          "lib"
        ],
        licenses: ["MIT"],
        links: %{"Github" => "https://github.com/hassox/c3p0"},
        maintainers: ["Daniel Neighman"]
      ],
      source_url: "https://github.com/hassox/c3p0"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    C3P0 is a collection of protocols designed to facilitate easy data manipulation.
    """
  end
end
