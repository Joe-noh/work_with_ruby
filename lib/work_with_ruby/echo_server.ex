defmodule WorkWithRuby.EchoServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def echo(string) do
    GenServer.call(__MODULE__, {:echo, string})
  end

  def init(_) do
    {:ok, []}
  end

  def handle_call({:echo, string}, _from, state) when is_binary(string) do
    IO.puts "Got \"#{string}\""
    {:reply, string, state}
  end
end
