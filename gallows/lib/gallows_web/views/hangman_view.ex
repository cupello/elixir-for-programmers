defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def join_with_space(list) do
    list
    |> Enum.join(" ")
  end
end
