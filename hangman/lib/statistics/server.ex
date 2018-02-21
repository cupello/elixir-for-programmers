defmodule Statistics.Server do
  alias Statistics.Data
  use GenServer

  @me __MODULE__

  def start_link() do
    GenServer.start_link(@me, [], name: @me)
  end

  def init(_args) do
    :ok = :net_kernel.monitor_nodes(true)
    {:ok, Data.init()}
  end

  def register_new_game() do
    GenServer.call(@me, {:register_new_game})
  end

  def handle_call({:register_new_game}, _from, stats) do
    stats = Data.update_new_games_count(stats)
    {:reply, :ok, stats}
  end

  def handle_info({state, node}, stats) when state in [:nodeup, :nodedown] do
    stats = Data.update_connected_nodes(stats, node, state)
    {:noreply, stats}
  end

  def handle_info(_message, stats) do
    # Ignoring unexpected message
    {:noreply, stats}
  end
end
