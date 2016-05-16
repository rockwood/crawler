defmodule Crawler.PageTest do
  use ExUnit.Case
  alias Crawler.Page

  test "from_url" do
    page = Page.from_url("http://example.com", %{id: 1})
    assert page.uri.host == "example.com"
    assert page.id == 1
  end
end
