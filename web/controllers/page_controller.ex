defmodule Objects.PageController do
  use Objects.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
