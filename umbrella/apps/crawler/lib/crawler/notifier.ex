defmodule Crawler.Notifier do
  use GenServer

  @name __MODULE__

  def start_link do
    GenServer.start_link(@name, [], name: @name)
  end

  def register(callback) do
    GenServer.call(@name, {:register, callback})
  end

  def notify(update) do
    GenServer.call(@name, {:notify, update})
  end

  def handle_call({:register, callback}, _from, callbacks) do
    {:reply, :ok, [callback | callbacks]}
  end

  def handle_call({:notify, update}, _from, callbacks) do
    Enum.each callbacks, fn(callback) ->
      callback.(update)
    end
    {:reply, :ok, callbacks}
  end
end
