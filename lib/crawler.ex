defmodule Crawler do
  alias Crawler.{Coordinator, Notifier, Page, PageState}

  def on_update(callback) do
    Notifier.register(callback)
  end

  def run(url) do
    url
    |> Page.from_url
    |> PageState.create
    |> Coordinator.fetch
  end
end
