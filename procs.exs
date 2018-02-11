defmodule Procs do
  @doc """
  iex(13)> pid = spawn Procs, :greeter, []
  #PID<0.122.0>
  iex(14)> send( pid, "rafa")
  Hello "rafa"
  "rafa"
  """
  def greeter() do
    receive do
      msg ->
        IO.puts("Hello #{inspect(msg)}")
    end

    greeter()
  end

  @doc """
  iex(17)> pid = spawn Procs, :greeter, ["Hello"]
  #PID<0.127.0>
  iex(18)> send( pid, "rafa")
  Hello: rafa
  "rafa"
  """
  def greeter(what_to_say) do
    receive do
      msg ->
        IO.puts("#{what_to_say}: #{msg}")
    end

    greeter(what_to_say)
  end

  @doc """
  iex(2)> spawn Procs, :greeter_with_counter , [0]
  #PID<0.92.0>
  iex(3)> pid = v(-1)
  #PID<0.92.0>
  iex(5)> send pid, "rafa"
  0: Hello "rafa"
  "rafa"
  iex(6)> send pid, {:add , 2}
  {:add, 2}
  iex(7)> send pid, "rafa"
  2: Hello "rafa"
  "rafa"
  iex(20)> send pid, {:reset}
  {:reset}
  iex(21)> send pid, "rafa"
  0: Hello "rafa"
  "rafa"
  """
  def greeter_with_counter(count) do
    receive do
      {:reset} ->
        greeter_with_counter(0)

      {:add, n} ->
        greeter_with_counter(count + n)

      msg ->
        IO.puts("#{count}: Hello #{inspect(msg)}")
        greeter_with_counter(count)
    end
  end
end
