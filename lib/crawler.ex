defmodule Crawler do
  alias Objects.Endpoint

  def run do
    Endpoint.broadcast("urls:test_url", "update", payload)
  end

  def payload do
    File.read!("test/fixtures/graph_payload.json") |> Poison.decode!
  end
end
