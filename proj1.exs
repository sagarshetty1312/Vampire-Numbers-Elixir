input = System.argv
first = List.first(input)
second = List.first(List.delete(input, first))
a=String.to_integer(first)
b=String.to_integer(second)
Proj.Application.start(:normal,(for i <- a..b,
#Check that the original number has even digits
VampireNumber.getCharLength(i) |> rem(2) == 0, do: i))
