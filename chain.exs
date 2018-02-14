defmodule Chain do
  @doc """
    iex --sname one chain.exs
    Chain.start_link :"two@cupello-Inspiron-7559"

    iex --sname two chain.exs
    Chain.start_link :"three@cupello-Inspiron-7559"

    iex --sname three chain.exs
    Chain.start_link :"four@cupello-Inspiron-7559"

    iex --sname four chain.exs
    Chain.start_link :"one@cupello-Inspiron-7559"

    iex(one@cupello-Inspiron-7559)3> send :chainer, {:trigger, []}

  """
  defstruct(
    next_node: nil,
    count: 4
  )

  def start_link(next_node) do
    spawn_link(Chain, :message_loop, [%Chain{next_node: next_node}])
    |> Process.register(:chainer)
  end

  def message_loop(%{count: 0}) do
    IO.puts("Done")
  end

  def message_loop(state) do
    receive do
      {:trigger, list} ->
        IO.inspect(list)
        :timer.sleep(500)
        send({:chainer, state.next_node}, {:trigger, [node() | list]})
    end

    message_loop(%{state | count: state.count - 1})
  end
end
