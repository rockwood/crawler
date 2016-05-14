defmodule Crawler.Page do
  defstruct id: -1, uri: %URI{}, body: "", hrefs: []

  def from_url(url, attrs \\ %{}) do
    struct(__MODULE__, Map.put(attrs, :uri, URI.parse(url)))
  end

  def fetched?(page) do
    page.body != ""
  end

  def valid?(%{uri: %{path: nil}}), do: true
  def valid?(page) do
    !String.match?(page.uri.path, ~r/(.pdf|.xml|.png|.jpg|.gif)/)
  end
end
