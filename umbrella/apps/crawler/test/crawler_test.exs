defmodule CrawlerTest do
  use ExUnit.Case

  # We need to name the process so we can send ourselves within the callback
  @process_name :crawler_test_process
  @url "http://fixtures.local/page_1.html"

  setup do
    Process.register self, @process_name
    :ok
  end

  test "run" do
    Crawler.on_update fn(update) ->
      send @process_name, {:handle_update, update}
    end

    Crawler.run(@url)

    assert_received {:handle_update, {:page, %{uri: %{ path: "/page_1.html" }}}}
    assert_received {:handle_update, {:page, %{uri: %{ path: "/page_2.html" }}}}
    assert_received {:handle_update, {:page, %{uri: %{ path: "/page_3.html" }}}}
    assert_received {:handle_update, {:page, %{uri: %{ path: "/page_4.html" }}}}
  end
end
