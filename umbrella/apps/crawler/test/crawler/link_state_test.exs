defmodule Crawler.LinkStateTest do
  use ExUnit.Case
  alias Crawler.{Link, LinkState}

  setup do
    on_exit(&LinkState.clear/0)
    :ok
  end

  test "add" do
    LinkState.add(%Link{source: 0, target: 1})
    assert LinkState.all == [%Link{source: 0, target: 1}]
  end
end
