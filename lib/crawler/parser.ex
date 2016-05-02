defmodule Crawler.Parser do
  def parse(page) do
    links = page.body
    |> Floki.find("a")
    |> Floki.attribute("href")

    %{page | links: links}
  end
end
