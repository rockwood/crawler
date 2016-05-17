defmodule Crawler.State do
  defstruct root: "", pages: %{}, links: [], callback: &__MODULE__.default_callback/1
  alias Crawler.{Page, Link}

  def process_page(state, page) do
    process_hrefs(state, page)
  end

  defp process_hrefs(state, page) do
    Enum.reduce(page.hrefs, state, fn(href, state) ->
      process_uri(state, page, href)
    end)
  end

  defp process_uri(state, source_page, uri) do
    {state, target_page} = get_or_put_page(state, uri)
    put_link(state, source_page, target_page)
  end

  defp get_or_put_page(state, uri) do
    if existing_page = state.pages["#{uri}"] do
      {state, existing_page}
    else
      put_page(state, uri)
    end
  end

  defp put_page(state, uri) do
    new_page = %Page{id: Enum.count(state.pages), uri: uri}
    state.callback.({:page, new_page})
    Crawler.fetch_page(state, new_page)
    {%{state | pages: Map.put(state.pages, "#{new_page.uri}", new_page)}, new_page}
  end

  defp put_link(state, source_page, target_page) do
    new_link = %Link{source: source_page.id, target: target_page.id}
    state.callback.({:link, new_link})
    %{state | links: [new_link | state.links]}
  end

  def default_callback(_), do: nil
end
