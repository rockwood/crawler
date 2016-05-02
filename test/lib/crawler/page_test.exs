defmodule Crawler.PageTest do
  use ExUnit.Case
  alias Crawler.Page

  test "from_url" do
    page = Page.from_url("http://example.com/page")

    assert page.host == "example.com"
    assert page.url == "http://example.com/page"
  end
end
