defmodule WorkWithRuby.EchoServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def hello do
    GenServer.call(__MODULE__, {:echo, "Hello\n"})
  end

  def init(_) do
    Process.flag(:trap_exit, true)

    rb_file = Path.join(:code.priv_dir(:work_with_ruby), "echo_server.rb")
    pid = Port.open({:spawn_executable, rb_file}, [:binary, :stream])

    {:ok, pid}
  end

  def handle_call({:echo, string}, _from, state) when is_binary(string) do
    IO.puts "Got \"#{string}\""

    Port.command(state, string)

    {:reply, string, state}
  end

  def handle_info({:EXIT, _, :normal}, state) do
    {:stop, :ok, state}
  end

  def handle_info(other, state) do
    IO.inspect other
    {:noreply, state}
  end
end
