defmodule Crawler.Page do
  defstruct [:url, :host, :body, :links]

  def from_url(url) do
    uri = URI.parse(url)

    struct(__MODULE__, %{
      url: url,
      host: uri.host,
      path: uri.path
    })
  end
end
