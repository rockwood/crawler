defmodule Objects.CrawlerChannel do
  use Phoenix.Channel

  def join("crawler:main", _message, socket) do
    {:ok, socket}
  end

  def handle_in("crawl", %{"url" => url}, socket) do
    Crawler.start_link url, fn(update) ->
      case update do
        {:page, new_page} ->
          push(socket, "new_page", Map.take(new_page, [:id, :uri]))
        {:link, new_link} ->
          push(socket, "new_link", new_link)
      end
    end

    {:noreply, socket}
  end
end
