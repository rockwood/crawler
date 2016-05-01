defmodule CrawlerTest do
  use ExUnit.Case

  test "start" do
    assert Crawler.fetch("http://example.com") == "WooHoo! http://example.com"
  end
end
