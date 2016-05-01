defmodule CrawlerTest do
  use ExUnit.Case

  setup do
    Crawler.start_link
    :ok
  end

  test "start" do
    assert Crawler.fetch("http://example.com") == "WooHoo! http://example.com"
  end
end
