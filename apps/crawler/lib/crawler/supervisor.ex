defmodule Crawler.Supervisor do
  use Supervisor
  alias Crawler.State
  @name :crawler_supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @name)
  end

  def start_crawler(url, callback) do
    state = %State{callback: callback, root: url}
    Supervisor.start_child(@name, [state])
  end

  def init(_) do
    children = [
      worker(Crawler, []),
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
