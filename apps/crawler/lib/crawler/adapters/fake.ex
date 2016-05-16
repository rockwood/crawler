defmodule Crawler.FakeAdapter do
  def get(page) do
    %{page | body: File.read!("test/fixtures/#{page.uri.path}")}
  end
end
