defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert Enum.all?(game.letters, &(&1 =~ ~r/[a-z]/))
  end

  test "state isn't changed for :won or lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, _} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn {guess, state}, game ->
      {game, _} = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end
end
