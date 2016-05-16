defmodule Crawler.Worker do
  use GenServer
  alias Crawler.Coordinator

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    {:ok, state}
  end

  def process_page(pid, page) do
    GenServer.call(pid, {:fetch, page}, :infinity)
  end

  def handle_call({:fetch, page}, _from, state) do
    {:reply, Coordinator.process_page(page), state}
  end
end
