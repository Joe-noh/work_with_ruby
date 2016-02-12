defmodule WorkWithRuby.EchoServer do
  @moduledoc ~S"""
  与えられた文字列をRubyプロセスに渡し、そのまま返してもらいます。

      iex> WorkWithRuby.EchoServer.echo("Hello")
      "Hello\n"
      iex> WorkWithRuby.EchoServer.echo("こんにちわ")
      "こんにちわ\n"
      iex> WorkWithRuby.EchoServer.echo("🍣🍺🍕")
      "🍣🍺🍕\n"
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def echo(message) when is_binary(message) do
    GenServer.call(__MODULE__, {:echo, message <> "\n"})
  end

  def init(_) do
    rb_file = Path.join(:code.priv_dir(:work_with_ruby), "echo.rb")
    pid = Port.open({:spawn_executable, rb_file}, [:binary])

    {:ok, pid}
  end

  def handle_call({:echo, message}, _from, pid) when is_binary(message) do
    Port.command(pid, message)

    receive do
      {^pid, {:data, content}} -> {:reply, content, pid}
    after 3000 ->
      {:stop, :timeout, pid}
    end
  end
end
