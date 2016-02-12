defmodule WorkWithRuby.JSONParser do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def parse(json) when is_binary(json) do
    GenServer.call(__MODULE__, {:parse, json})
  end

  def init(_) do
    rb_file = Path.join(:code.priv_dir(:work_with_ruby), "json_parser.rb")
    pid = Port.open({:spawn_executable, rb_file}, [:binary, packet: 4])

    {:ok, pid}
  end

  def handle_call({:parse, json}, _from, pid) when is_binary(json) do
    Port.command(pid, json)

    receive do
      {^pid, {:data, content}} -> {:reply, content, pid}
      other -> {:reply, other, pid}
    after 3000 ->
      {:stop, :timeout, pid}
    end
  end
end
