defmodule Objects.UrlChannel do
  use Phoenix.Channel

  def join("urls:test_url", _message, socket) do
    {:ok, socket}
  end
end
