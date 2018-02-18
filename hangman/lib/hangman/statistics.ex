defmodule Hangman.Statistics do
  @me __MODULE__

  defstruct(new_games_count: 0)

  def start_link() do
    Agent.start_link(fn -> %Hangman.Statistics{} end, name: @me)
  end

  def register_new_game() do
    Agent.update(@me, fn stats ->
      update_new_games_count(stats)
      |> display()
    end)
  end

  defp update_new_games_count(stats) do
    Map.put(stats, :new_games_count, stats.new_games_count + 1)
  end

  defp display(stats) do
    IO.puts([
      "NEW_GAMES_COUNT: #{stats.new_games_count}",
      "\n"
    ])

    stats
  end
end
