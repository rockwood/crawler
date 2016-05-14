defmodule Crawler.NotifierTest do
  use ExUnit.Case
  alias Crawler.{Notifier, Page}

  # We need to name the process so we can send ourselves within the callback
  @process_name :notifier_test_process

  setup do
    Process.register self, @process_name
    {:ok, page: Page.from_url("http://example.com")}
  end

  test "notify: when a callback is registered", %{page: page} do
    Notifier.register fn (saved_page) ->
      send @process_name, {:handle_add_page, saved_page}
    end

    Notifier.notify(page)

    assert_received {:handle_add_page, page}
  end
end
