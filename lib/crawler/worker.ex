defmodule Crawler.Worker do
  use GenServer
  alias Crawler.HttpAdapter

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    {:ok, state}
  end

  def fetch(pid, url) do
    GenServer.call(pid, {:fetch, url})
  end

  def handle_call({:fetch, url}, _from, state) do
    result = HttpAdapter.get(url)
    {:reply, result, state}
  end
end
