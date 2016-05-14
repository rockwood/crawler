defmodule Crawler do
  alias Crawler.{Coordinator, Notifier, Page, PageState}

  def run(url, callback) do
    Notifier.register(callback)
    url
    |> Page.from_url
    |> PageState.create
    |> Coordinator.fetch
  end
end
