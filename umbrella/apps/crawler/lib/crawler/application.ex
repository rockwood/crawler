defmodule Crawler.Application do
  use Application

  @pool_name :crawler
  @pool_config [
    {:name, {:local, @pool_name}},
    {:worker_module, Crawler.Worker},
    {:size, 20},
    {:max_overflow, 1}
  ]

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      :poolboy.child_spec(@pool_name, @pool_config, []),
      worker(Crawler.PageState, []),
      worker(Crawler.LinkState, []),
      worker(Crawler.Notifier, []),
    ]

    opts = [strategy: :one_for_one, name: Crawler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
