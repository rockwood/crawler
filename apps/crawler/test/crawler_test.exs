defmodule CrawlerTest do
  use ExUnit.Case

  # We need to name the process so we can send ourselves within the callback
  @process_name :crawler_test_process
  @url "http://fixtures.local/page_1.html"

  setup do
    Process.register(self, @process_name)

    Crawler.start_link @url, fn(update) ->
      send(@process_name, update)
    end
    :ok
  end

  test "run" do
    assert_receive {:page, %{uri: %{ path: "/page_1.html" }}}
    assert_receive {:page, %{uri: %{ path: "/page_2.html" }}}
    assert_receive {:page, %{uri: %{ path: "/page_3.html" }}}
    assert_receive {:page, %{uri: %{ path: "/page_4.html" }}}

    assert_receive {:link, %Crawler.Link{source: 0, target: 0}}
    assert_receive {:link, %Crawler.Link{source: 0, target: 1}}
    assert_receive {:link, %Crawler.Link{source: 0, target: 2}}
    assert_receive {:link, %Crawler.Link{source: 1, target: 3}}
    assert_receive {:link, %Crawler.Link{source: 2, target: 3}}
    assert_receive {:link, %Crawler.Link{source: 3, target: 0}}
    assert_receive {:link, %Crawler.Link{source: 3, target: 1}}
  end
end
