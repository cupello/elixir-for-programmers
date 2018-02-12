defmodule Cache.Application do
  use Application

  def start(_type, _args) do
    Cache.MapCache.start_link()
  end
end
