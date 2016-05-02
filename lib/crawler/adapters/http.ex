defmodule Crawler.HttpAdapter do
  def get(page) do
    response = HTTPoison.get!(page.url)
    %{page | body: response.body}
  end
end
