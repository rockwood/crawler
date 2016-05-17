defmodule Crawler.FetcherTest do
  use ExUnit.Case
  alias Crawler.{Fetcher, Page}

  test "fetch" do
    {:ok, page} = "http://fixtures.local/page_1.html"
    |> Page.from_url()
    |> Fetcher.fetch

    assert [%{path: "/page_2.html"}, %{path: "/page_3.html"}] = page.hrefs
  end
end
