defmodule Crawler.HttpAdapter do
  alias Crawler.Page

  def get(page) do
    if Page.valid?(page) do
      case make_request(page) do
        {:ok, response} ->
          %{page | body: response.body}
        {:error, _} ->
          page
      end
    else
      page
    end
  end

  def make_request(page) do
    page.uri
    |> URI.to_string
    |> HTTPoison.get
  end
end
