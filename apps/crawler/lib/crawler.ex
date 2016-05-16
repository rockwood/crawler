defmodule Crawler do
  alias Crawler.{Coordinator, Notifier, Page, PageState}
  use GenServer

  def on_update(callback) do
    Notifier.register(callback)
  end

  def run(url) do
    url
    |> Page.from_url
    |> PageState.create
    |> Coordinator.fetch
  end

  def start_link(url) do
    GenServer.start_link(__MODULE__, [], name: via_tuple(url))
  end

  defp via_tuple(url) do
    {:via, Crawler.Registry, {:crawler, url}}
  end
end
