str = "had we but world enough, and time"

String.split(str, ",")

# each entry in the list is a single character string.
String.codepoints(str)

# each entry in the list is the integer representation of that character
String.to_charlist(str)

String.reverse(str)

String.myers_difference(str, "had we but bacon enough, and treacle")

# iex(9)> str = "ã"
# "ã"
# iex(10)> str <> <<0>>
# <<195, 163, 0>>
# iex(11)> String.to_charlist(str)
# [227]
