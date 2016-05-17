defmodule Crawler.Application do
  use Application

  @pool_name Application.get_env(:crawler, :pool_name)
  @pool_config [
    {:name, {:local, @pool_name}},
    {:worker_module, Crawler.Worker},
    {:size, 10},
    {:max_overflow, 1}
  ]

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      :poolboy.child_spec(@pool_name, @pool_config, []),
      worker(Crawler.Registry, []),
    ]

    opts = [strategy: :one_for_one, name: Crawler.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_crawler(url) do
    Supervisor.start_child(Crawler.Supervisor, [url])
  end
end
