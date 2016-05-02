defmodule Crawler.Coordinator do
  alias Crawler.{Page, HttpAdapter, Parser}

  def fetch(url) do
    page = url
    |> Page.from_url
    |> HttpAdapter.get
    |> Parser.parse
  end
end
