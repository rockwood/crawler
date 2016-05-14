defmodule Crawler.PageStateTest do
  use ExUnit.Case
  alias Crawler.{Page, PageState}

  setup do
    on_exit(&PageState.clear/0)
    :ok
  end

  test "create_or_update: with a new page" do
    page_0 = PageState.create_or_update(%Page{uri: URI.parse("http://example.com/page_0")})
    page_1 = PageState.create_or_update(%Page{uri: URI.parse("http://example.com/page_1")})
    assert page_0.id != page_1.id
    assert PageState.all |> Enum.count == 2
  end

  test "create_or_update: with an existing page" do
    page_0 = PageState.create_or_update(%Page{uri: URI.parse("http://example.com/page_0")})
    page_1 = PageState.create_or_update(%Page{uri: URI.parse("http://example.com/page_0")})
    assert page_0.id == page_1.id
    assert PageState.all |> Enum.count == 1
  end

  test "create_or_update: with an existing page and new body" do
    page_0 = PageState.create_or_update(%Page{uri: URI.parse("http://example.com/page_0"), body: ""})
    page_1 = PageState.create_or_update(%Page{uri: URI.parse("http://example.com/page_0"), body: "new body"})
    assert page_0.id == page_1.id
    assert page_1.body == "new body"
  end

  test "get: with a new page" do
    page = %Page{uri: URI.parse("http://example.cam")}
    refute PageState.get(page)
  end

  test "get: with an existing page" do
    PageState.add(%Page{uri: URI.parse("http://example.com")})
    page = %Page{uri: URI.parse("http://example.com")}
    assert PageState.get(page)
  end
end
