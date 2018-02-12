defmodule Fibonacci.LinearTime do
  def fib(n) do
    Cache.put(0, 0)
    Cache.put(1, 1)
    cached_fib(n)
  end

  defp cached_fib(n) do
    cond do
      result = Cache.get(n) ->
        result

      true ->
        Cache.put(n, fib(n - 1) + fib(n - 2))
    end
  end
end
