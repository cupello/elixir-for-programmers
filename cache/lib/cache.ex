defmodule Cache do
  alias Cache.MapCache
  defdelegate get(key), to: MapCache
  defdelegate put(key, value), to: MapCache
end
