defmodule WorkWithRuby do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(WorkWithRuby.EchoServer, []),
      worker(WorkWithRuby.JSONParser, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WorkWithRuby.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
