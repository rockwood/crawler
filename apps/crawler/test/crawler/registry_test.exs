defmodule Crawler.RegistryTest do
  use ExUnit.Case
  alias Crawler.Registry

  @url "http://fixtures.local/page_1.html"

  test "register_name adds the crawler process" do
    pid = spawn(fn -> nil end)
    Registry.register_name(@url, pid)

    assert Registry.whereis_name(@url) == pid
  end
end
