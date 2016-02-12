defmodule WorkWithRubyTest do
  use ExUnit.Case

  test "echo" do
    assert WorkWithRuby.EchoServer.echo("Hello") == "Hello\n"
    assert WorkWithRuby.EchoServer.echo("こんにちわ") == "こんにちわ\n"
    assert WorkWithRuby.EchoServer.echo("🍣🍺🍕") == "🍣🍺🍕\n"
  end

  test "miltiline" do
    input = """
    {
      "name": "Mary",
      "age": 20
    }
    """

    assert WorkWithRuby.JSONParser.parse(input) == "Name is Mary, 20 years old."
  end
end

