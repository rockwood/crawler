defmodule Crawler.CoordinatorTest do
  use ExUnit.Case
  alias Crawler.{Coordinator, Page, PageState, LinkState}

  setup do
    on_exit(&LinkState.clear/0)
    on_exit(&PageState.clear/0)
    Page.from_url("http://fixtures.local/page_1.html") |> Coordinator.fetch
    :ok
  end

  test "fetch" do
    assert Enum.count(PageState.all) == 3
    assert Enum.count(LinkState.all) == 2
  end
end
