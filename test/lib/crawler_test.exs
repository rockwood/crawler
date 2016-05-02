defmodule CrawlerTest do
  use ExUnit.Case

  test "start" do
    page = Crawler.fetch("http://example.com")
    assert hd(page.links) == "http://www.iana.org/domains/example"
  end
end
