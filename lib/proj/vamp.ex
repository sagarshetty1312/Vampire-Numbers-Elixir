defmodule VampireNumber do
  use GenServer

  def start_link do
    #IO.puts "worker start"
    GenServer.start_link(__MODULE__,[])
  end

  def init([]) do
    {:ok,[]}
  end

  def dowork(process_id, {list, parent_pid}) do
    GenServer.cast(process_id, {list, parent_pid})
  end

  def handle_cast({list, parent_pid}, _pid) do
      doCalcAndRespond(list,parent_pid)
      {:noreply, list}
  end

  def doCalcAndRespond(list, parent_pid) do
    send(parent_pid, {:fromGenServer, VampireNumber.getVampireNumbersAndFangs list})
  end

  @doc """
  Function to get the number of digits in an integer
  """
  def getCharLength(num) do
    to_charlist(num) |> length
  end

  @doc """
  Function to get all permutations and print if its a vampire number
  """
  def getPermutationsAndCheckIfVampire(list, num) do
    for i <- Combination.permutate(list),
    #Check that number is a factor
    (rem(num, List.to_integer(i)) == 0)
    #Check that length of number is half of that of the original number
    && ((div(num, List.to_integer(i)) |> getCharLength) == div(getCharLength(num),2))
    #Check that both numbers don't end with zero
    && ((rem(List.to_integer(i),10) != 0) || (rem(div(num, List.to_integer(i)),10) != 0))
    #Check that the numbers have the same digits as the original number
    && Enum.sort(to_charlist num)
    ==Enum.sort( to_charlist "#{i}#{div(num, List.to_integer(i))}"),
     do: List.to_integer(i)
  end

  @doc """
    Function to return list[1..n] after ordering it like list[1, n, 2, n-1, 3, n-2...]
  """
  def orderList([]), do: []
  def orderList(list) do
    List.flatten [hd(list), List.delete_at(list,0) |> Enum.reverse |> orderList]
  end

  @doc """
  Function that returns a list of all permutations that are fangs to the original number
  """
  def checkForVampireNumber(num) do
    half = div(getCharLength(num), 2)
    #Get a list of all combinations with half the digits as the original number
    # and loop through it
     factorList = for i <- Combination.combine(to_charlist(num),half),
    (List.to_integer(i) != 0),
    do: getPermutationsAndCheckIfVampire i, num
    flatList = List.flatten factorList
    resultList = Enum.uniq flatList |> Enum.sort

    unless length(resultList) == 0 do
      orderList resultList
    else
      []
    end
  end

  @doc """
  Funtion to get a list[1..n] and return a list of vampire numbers and fangs
  """
  def getVampireNumbersAndFangs list do
    list1 = for i <- list, do: [i | checkForVampireNumber i ]
    for i <- list1, Enum.count(i) > 1, do: i
  end
end
