defmodule Crawler.StateTest do
  use ExUnit.Case

  alias Crawler.{State, Page}
  @url "http://fixtures.local/page_1.html"

  setup do
    hrefs = [URI.parse("http://fixtures.local/page_2.html"), URI.parse("http://fixtures.local/page_3.html")]
    page = Page.from_url(@url, %{hrefs: hrefs})

    {:ok, page: page, state: %State{}}
  end

  test "process", %{page: page, state: state} do
    new_state = State.process_page(state, page)

    assert Enum.count(new_state.links) == 2
    assert %{id: 0, uri: %{path: "/page_2.html"}} = new_state.pages["http://fixtures.local/page_2.html"]
    assert %{id: 1, uri: %{path: "/page_3.html"}} = new_state.pages["http://fixtures.local/page_3.html"]
  end
end
