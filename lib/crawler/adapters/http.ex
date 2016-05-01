defmodule Crawler.HttpAdapter do
  def get(url) do
    Objects.Endpoint.broadcast("urls:test_url", "update", payload)
    "WooHoo! #{url}"
  end

  def payload do
    File.read!("test/fixtures/graph_payload.json") |> Poison.decode!
  end
end
