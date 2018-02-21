defmodule Statistics.Data do
  defstruct(
    new_games_count: 0,
    connected_nodes: MapSet.new()
  )

  def init() do
    %Statistics.Data{}
  end

  def update_new_games_count(stats) do
    Map.put(stats, :new_games_count, stats.new_games_count + 1)
    |> display()
  end

  def update_connected_nodes(stats, node) do
    Map.put(stats, :connected_nodes, MapSet.put(stats.connected_nodes, node))
    |> display()
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
