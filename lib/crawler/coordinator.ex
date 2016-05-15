defmodule Crawler.Coordinator do
  alias Crawler.{Parser, Page, PageState, Link, LinkState, Worker}
  require Logger

  @pool_name :crawler
  @config Application.get_env(:objects, Crawler)

  def fetch(page) do
    if !Page.fetched?(page) do
      process_page_in_transaction(page)
    end
  end

  defp process_page_in_transaction(page) do
    :poolboy.transaction(@pool_name, fn(pid) ->
      Worker.process_page(pid, page)
    end, :infinity)
  end

  def process_page(page) do
    page
    |> log
    |> adapter.get
    |> Parser.parse
    |> PageState.update
    |> process_hrefs
  end

  defp process_hrefs(page) do
    Enum.each page.hrefs, fn(uri) ->
      existing_page = PageState.get(%Page{uri: uri})

      if existing_page do
        LinkState.add(%Link{source: page.id, target: existing_page.id})
      else
        new_page = PageState.create(%Page{uri: uri})
        LinkState.add(%Link{source: page.id, target: new_page.id})
        fetch(new_page)
      end
    end

    page
  end

  defp log(page) do
    Logger.info("Crawling: #{page.uri}")
    page
  end

  def adapter do
    @config[:adapter] || Crawler.HttpAdapter
  end
end
