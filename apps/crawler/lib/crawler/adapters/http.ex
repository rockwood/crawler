defmodule Crawler.HttpAdapter do
  alias Crawler.Page

  def get(page) do
    case make_request(page) do
      {:ok, response} ->
        append_response_body(page, response)
      _ ->
        page
    end
  end

  def make_request(page) do
    page.uri
    |> URI.to_string
    |> HTTPoison.get
  end

  def append_response_body(page, response) do
    case :proplists.get_value("Content-Type", response.headers) do
      "text/html; charset=utf-8" ->
        Map.put(page, :body, response.body)
      "text/html" ->
        Map.put(page, :body, response.body)
      _ ->
        page
    end
  end
end
