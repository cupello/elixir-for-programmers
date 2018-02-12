defmodule Cache do
  def load_cache() do
    Agent.start_link(fn -> %{} end)
  end

  def add(pid, key, value) do
    Agent.get_and_update(pid, fn map -> {value, Map.put(map, key, value)} end)
  end

  def get(pid, key) do
    Agent.get(pid, & &1[key])
  end
end

defmodule LinearFibonacci do
  def fib(n) do
    {_, pid} = Cache.load_cache()
    Cache.add(pid, 0, 0)
    Cache.add(pid, 1, 1)
  end

  defp fib(pid, n) do
    cond do
      result = Cache.get(pid, n) ->
        result

      true ->
        result = fib(pid, n - 1) + fib(pid, n - 2)
        Cache.add(pid, n, result)
    end
  end
end
