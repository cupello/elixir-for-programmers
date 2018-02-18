defmodule Hangman.Statistics do
  @me __MODULE__

  defstruct(
    new_games_count: 0,
    connected_nodes: MapSet.new()
  )

  def start_link() do
    Agent.start_link(fn -> %Hangman.Statistics{} end, name: @me)
  end

  def register_new_game(_ = %{node_name: node_name}) do
    Agent.update(@me, fn stats ->
      update_new_games_count(stats)
      |> update_connected_nodes(node_name)
      |> display()
    end)
  end

  defp update_new_games_count(stats) do
    Map.put(stats, :new_games_count, stats.new_games_count + 1)
  end

  defp update_connected_nodes(stats, node_name) do
    Map.put(stats, :connected_nodes, MapSet.put(stats.connected_nodes, node_name))
  end

  defp display(stats) do
    IO.puts([
      "NEW_GAMES_COUNT: #{stats.new_games_count}",
      "\n",
      "CONNECTED_NODES: #{Enum.join(stats.connected_nodes, ", ")}",
      "\n"
    ])

    stats
  end
end
