defmodule Fibonacci do
  alias Fibonacci.LinearTime

  defdelegate fib(n), to: LinearTime
end
