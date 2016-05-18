defmodule Crawler.HttpAdapter do
  alias Crawler.Page

  def get(page) do
    with {:ok, response} <- make_request(page.uri) do
      {:ok, %{page | body: response.body}}
    end
  end

  defp make_request(uri) do
    uri
    |> URI.to_string
    |> HTTPoison.get
    |> process_response
  end

  defp process_response({:error, error}), do: {:error, error}
  defp process_response({:ok, response}) do
    if valid_content_type?(response) do
      {:ok, response}
    else
      {:error, "Invalid content type"}
    end
  end

  def valid_content_type?(response) do
    Enum.find_value response.headers, fn({key, content_type}) ->
      if String.downcase(key) == "content-type" do
        content_type |> String.downcase |> String.contains?("text/html")
      end
    end
  end
end
