shopping = [
  {"1 dozen", "eggs"},
  {"1 ripe", "melon"},
  {"4", "apples"},
  {"2 boxes", "tea"}
]

template = """
quantity | item
--------------------
<%= for {quantity, item} <- shopping do %>
<%= String.pad_leading(quantity, 8)%> | <%= item %>
<% end %>
"""

IO.puts(EEx.eval_string(template, [shopping: shopping], trim: true))
