defmodule PatternMatch do
  def swap({a, b}), do: {b, a}

  def same?(a, a), do: true
  def same?(a, b), do: false
end
