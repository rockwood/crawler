defmodule Crawler.ParserTest do
  use ExUnit.Case
  alias Crawler.{Page, Parser}

  test "parse" do
    page = Page.from_url("http://fixtures.local", %{body: File.read!("test/fixtures/page_1.html")})
    parsed_page = Parser.parse(page)
    assert Enum.count(parsed_page.hrefs) == 2
  end

  test "uri_for: with a relative path" do
    page = Page.from_url("http://example.com")
    assert Parser.uri_for(page, "/page_2") == URI.parse("http://example.com/page_2")
  end

  test "uri_for: with a non_relative path" do
    page = Page.from_url("http://example.com")
    assert Parser.uri_for(page, "http://example.com/page_2") == URI.parse("http://example.com/page_2")
  end

  test "uri_for: with a no scheme" do
    page = Page.from_url("https://example.com")
    assert Parser.uri_for(page, "//example.com/page_2") == URI.parse("https://example.com/page_2")
  end
end
