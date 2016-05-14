defmodule Crawler.PageState do
  alias Crawler.Notifier

  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def get(page) do
    Agent.get(__MODULE__, fn(pages) -> pages["#{page.uri}"] end)
  end

  def all do
    Agent.get(__MODULE__, &(&1))
  end

  def create(page) do
    Agent.get_and_update __MODULE__, fn(pages) ->
      new_page = page
      |> Map.put(:id, Enum.count(pages))
      |> Notifier.notify
      {new_page, Map.put(pages, "#{new_page.uri}", new_page)}
    end
  end

  def update(page) do
    Agent.get_and_update __MODULE__, fn(pages) ->
      {page, Map.put(pages, "#{page.uri}", page)}
    end
  end

  def clear do
    :ok = Agent.update(__MODULE__, fn(_) -> Map.new end)
  end
end
