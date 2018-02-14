defmodule Demo do
  @doc """

      ### NODE ONE
      iex --sname one
      
      iex(one@cupello)6> c "demo.exs"
      [Demo]

      iex(one@cupello)7> pid = spawn Demo, :reverse, []
      #PID<0.105.0>

      iex(one@cupello)8> Process.register pid , :rev
      true

      iex(one@cupello)9> send(:rev, {self(), "hello"})
      {#PID<0.91.0>, "hello"}

      iex(one@cupello)10> flush()
      "olleh"
      :ok

      ### NODE TWO
      iex --sname two

      iex(two@cupello)2> send({:rev, :one@cupello}, {self(), "hello"})
      {#PID<0.91.0>, "hello"}

      iex(two@cupello)3> flush
      "olleh"
      :ok
  """
  def reverse do
    receive do
      {from_pid, msg} ->
        result = msg |> String.reverse()
        send(from_pid, result)
        reverse()
    end
  end
end
