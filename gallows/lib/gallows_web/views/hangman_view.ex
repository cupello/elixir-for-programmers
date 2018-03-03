defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import Gallows.Views.Helpers.GameStateHelper

  def turn(left, target) when target >= left do
    ""
  end

  def turn(_left, _target) do
    "faint"
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end

  def new_game_button(conn) do
    button("New Game", to: hangman_path(conn, :create_game))
  end

  def join_with_space(list) do
    list
    |> Enum.join(" ")
  end
end
