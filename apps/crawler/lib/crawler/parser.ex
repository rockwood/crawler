defmodule Crawler.Parser do
  alias Crawler.Page

  def parse(page) do
    page
    |> put_hrefs
  end

  def put_hrefs(page) do
    hrefs = page.body
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.map(fn(href) -> uri_for(page, href) end)

    Map.put(page, :hrefs, hrefs)
  end

  def uri_for(parent_page, href) do
    case URI.parse(href) do
      uri = %URI{host: host} when is_binary(host) ->
        %{uri | scheme: uri.scheme || parent_page.uri.scheme, port: uri.port || parent_page.uri.port}
      _ ->
        URI.parse("#{parent_page.uri.scheme}://#{parent_page.uri.host}#{href}")
    end
  end
end
