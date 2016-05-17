defmodule Crawler.State do
  defstruct callback: nil, pages: %{}, links: []
  alias Crawler.{Page, Link}

  def from_callback(callback) do
    struct(__MODULE__, %{callback: callback})
  end

  def process_page(state, page) do
    process_hrefs(state, page)
  end

  defp process_hrefs(state, page) do
    Enum.reduce(page.hrefs, state, fn(href, state) ->
      {pages, target_page} = get_or_put_page(state.pages, href)
      new_link = %Link{source: page.id, target: target_page.id}
      %{state | pages: pages, links: [new_link | state.links]}
    end)
  end

  defp get_or_put_page(pages, uri) do
    if existing_page = pages["#{uri}"] do
      {pages, existing_page}
    else
      new_page = %Page{id: Enum.count(pages), uri: uri}
      {Map.put(pages, "#{new_page.uri}", new_page), new_page}
    end
  end
end
