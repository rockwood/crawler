defmodule Crawler do
  use Application
  alias Crawler.Worker

  @pool_name :crawler
  @pool_config [
    {:name, {:local, @pool_name}},
    {:worker_module, Crawler.Worker},
    {:size, 2},
    {:max_overflow, 1}
  ]

  def start_link do
    children = [
      :poolboy.child_spec(@pool_name, @pool_config, [])
    ]

    options = [
      strategy: :one_for_one,
      name: Crawler.Supervisor
    ]

    Supervisor.start_link(children, options)
  end

  def fetch(url) do
    :poolboy.transaction @pool_name, fn(pid) ->
      Worker.fetch(pid, url)
    end
  end
end
