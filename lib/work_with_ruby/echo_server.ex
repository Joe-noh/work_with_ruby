defmodule WorkWithRuby.EchoServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    IO.puts "#{__MODULE__} started"
    {:ok, []}
  end
end
