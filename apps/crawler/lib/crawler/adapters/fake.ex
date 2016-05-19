defmodule Crawler.FakeAdapter do
  def get(page) do
    {:ok, %{page | body: File.read!("test/fixtures/#{page.uri.path}")}}
  end
end
