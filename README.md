# Port Example

Elixir communicates with Ruby.

## Try

```
$ iex -S mix
```

```elixir
# WrokWithRuby.EchoServer starts a ruby process

iex> WorkWithRuby.EchoServer.hello
{#Port<0.3951>, {:data, "Hello\n"}}  # Response from the ruby process
```
