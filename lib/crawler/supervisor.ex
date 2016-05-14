defmodule Crawler.Supervisor do
  use Supervisor

  @pool_name :crawler
  @pool_config [
    {:name, {:local, @pool_name}},
    {:worker_module, Crawler.Worker},
    {:size, 20},
    {:max_overflow, 1}
  ]

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      :poolboy.child_spec(@pool_name, @pool_config, []),
      worker(Crawler.PageState, []),
      worker(Crawler.LinkState, []),
      worker(Crawler.Notifier, []),
    ]

    options = [
      strategy: :one_for_one
    ]

    supervise(children, options)
  end
end
