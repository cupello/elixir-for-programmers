defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel
  require Logger

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    {:ok, socket}
  end

  def handle_in("tally", _, socket) do
    tally =
      socket.assigns.game
      |> Hangman.tally()

    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in(invalid_message, _, socket) do
    Logger.error("Invalid message: #{invalid_message}")
    {:noreply, socket}
  end
end
