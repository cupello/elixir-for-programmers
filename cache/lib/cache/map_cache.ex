defmodule Cache.MapCache do
  @me __MODULE__

  def start_link() do
    Agent.start_link(fn -> %{} end, name: @me)
  end

  def put(key, value) do
    Agent.get_and_update(@me, fn map -> {value, Map.put(map, key, value)} end)
  end

  def get(key) do
    Agent.get(@me, & &1[key])
  end
end
