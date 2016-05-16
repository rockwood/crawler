defmodule Crawler.RegistryTest do
  use ExUnit.Case
  alias Crawler.Registry

  @url "http://example.com"

  test "register_name adds the crawler process" do
    {:ok, crawler_pid} = Crawler.start_link(@url)
    Registry.register_name(@url, crawler_pid)

    assert Registry.whereis_name(@url) == crawler_pid
  end
end
