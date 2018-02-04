defmodule Lists do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def even_length?([]), do: true
  def even_length?([_]), do: false
  def even_length?([_, _ | tail]), do: even_length?(tail)
end
