defmodule Crawler.Registry do
  use GenServer
  @name :crawler_registry

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def whereis_name(url) do
    GenServer.call(@name, {:whereis_name, url})
  end

  def register_name(url, pid) do
    GenServer.call(@name, {:register_name, url, pid})
  end

  def unregister_name(url) do
    GenServer.cast(@name, {:unregister_name, url})
  end

  def send(url, message) do
    case whereis_name(url) do
      :undefined ->
        {:badarg, {url, message}}
      pid ->
        Kernel.send(pid, message)
        pid
    end
  end

  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:whereis_name, url}, _from, state) do
    {:reply, Map.get(state, url, :undefined), state}
  end

  def handle_call({:register_name, url, pid}, _from, state) do
    case Map.get(state, url) do
      nil ->
        {:reply, :yes, Map.put(state, url, pid)}
      _ ->
        {:reply, :no, state}
    end
  end

  def handle_cast({:unregister_name, url}, state) do
    {:noreply, Map.delete(state, url)}
  end
end
