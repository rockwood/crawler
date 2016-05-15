defmodule Crawler.PageStateTest do
  use ExUnit.Case
  alias Crawler.{Page, PageState}

  setup do
    on_exit(&PageState.clear/0)
    :ok
  end

  test "create: with a new page" do
    page_0 = PageState.create(%Page{uri: URI.parse("http://example.com/page_0")})
    page_1 = PageState.create(%Page{uri: URI.parse("http://example.com/page_1")})
    assert page_0.id != page_1.id
    assert PageState.all |> Enum.count == 2
  end

  test "update: with an existing page and new body" do
    page = PageState.create(%Page{uri: URI.parse("http://example.com/page_0"), body: ""})
    updated_page = PageState.update(%{page | body: "new body"})
    assert page.id == updated_page.id
    assert updated_page.body == "new body"
  end

  test "get: with a new page" do
    page = %Page{uri: URI.parse("http://example.cam")}
    refute PageState.get(page)
  end

  test "get: with an existing page" do
    PageState.create(%Page{uri: URI.parse("http://example.com")})
    page = %Page{uri: URI.parse("http://example.com")}
    assert PageState.get(page)
  end
end
