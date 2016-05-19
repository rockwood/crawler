defmodule Crawler do
  alias Crawler.{Page, State, Fetcher}
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: via_tuple(state))
  end

  def fetch_page(state, page) do
    GenServer.cast(via_tuple(state), {:fetch_page, page})
  end

  defp via_tuple(state) do
    {:via, Crawler.Registry, {:crawler, state.root}}
  end

  # Server

  def init(state) do
    root_page = Page.from_url(state.root, %{id: 0})
    fetch_page(state, root_page)
    {:ok, state}
  end

  def handle_cast({:fetch_page, page}, state) do
    case Fetcher.fetch(page) do
      {:ok, fetched_page} ->
        {:noreply, Crawler.State.process_page(state, fetched_page)}
      {:error, _} ->
        {:noreply, state}
    end
  end
end
