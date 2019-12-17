defmodule Proj.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, list) do

    {:ok, pid1} = VampireNumber.start_link
    VampireNumber.dowork(pid1,{(for i <- list, rem(i,4) == 0, do: i), self()})

    {:ok, pid2} = VampireNumber.start_link
    VampireNumber.dowork(pid2,{(for i <- list, rem(i,4) == 1, do: i), self()})

    {:ok, pid3} = VampireNumber.start_link
    VampireNumber.dowork(pid3,{(for i <- list, rem(i,4) == 2, do: i), self()})

    {:ok, pid4} = VampireNumber.start_link
    VampireNumber.dowork(pid4,{(for i <- list, rem(i,4) == 3, do: i), self()})

    loop(4)
  end

  def loop(0), do: nil
  def loop(counter) do
    #IO.puts("In parent loop: #{counter} ")
    receive do
      {:fromGenServer, resultList} -> printListMethod resultList
      {:whatever, _} -> IO.puts "do nothing"
    end
    loop(counter-1)
  end

  def printListMethod(list) do
    unless Enum.count(list) == 0 do
      #IO.puts "List in parent: #{inspect list}"
      for i <- list, do: IO.puts "#{inspect i}"
    end
  end
end
