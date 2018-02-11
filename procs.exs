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
end
