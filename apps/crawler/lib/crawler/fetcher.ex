defmodule Crawler.Fetcher do
  alias Crawler.{Parser, Worker}
  require Logger

  @pool_name Application.get_env(:crawler, :pool_name)
  @adapter Application.get_env(:crawler, :adapter)

  def fetch(page) do
    do_fetch_in_transaction(page)
  end

  defp do_fetch_in_transaction(page) do
    :poolboy.transaction(@pool_name, fn(pid) ->
      Worker.process_page(pid, page)
    end, :infinity)
  end

  def do_fetch(page) do
    fetched_page = page
    |> @adapter.get
    |> Parser.parse

    log(fetched_page)

    {:ok, fetched_page}
  end

  defp log(page) do
    Logger.info("Fetching: #{page.uri}, links: #{Enum.count(page.hrefs)}")
  end
end
