defmodule Crawler.LinkState do
  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add(link) do
    Agent.update(__MODULE__, fn(state) -> [link | state] end)
  end

  def all do
    Agent.get(__MODULE__, fn(state) -> state end)
  end

  def clear do
    :ok = Agent.update(__MODULE__, fn(_) -> [] end)
  end
end
