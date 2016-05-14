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
    Crawler.run @url, fn(fetched_page) ->
      send @process_name, {:handle_add_page, fetched_page}
    end

    assert_received {:handle_add_page, %{uri: %{ path: "/page_1.html" }}}
    assert_received {:handle_add_page, %{uri: %{ path: "/page_2.html" }}}
    assert_received {:handle_add_page, %{uri: %{ path: "/page_3.html" }}}
    assert_received {:handle_add_page, %{uri: %{ path: "/page_4.html" }}}
  end
end
