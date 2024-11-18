# BanditNative

Bandit Native is a companion package for [bandit](https://github.com/mtrudel/bandit) (a webserver implementation in Elixir)
which improves performance and efficiency of bandit even more.

## Installation

```elixir
def deps do
  [
    {:bandit_native, github: "alisinabh/bandit_native"}
  ]
end
```

Then configure your bandit server to use `BanditNative` like this.

```elixir
children = [
  {Bandit,
    plug: MyRouter,
    scheme: :http,
    port: 4004,
    websocket_options: [primitive_ops_module: BanditNative.WebSocket]},
  ...
]
```

Or in case of a [phoenix endpoint](https://hexdocs.pm/bandit/Bandit.PhoenixAdapter.html#module-endpoint-configuration) you can add it to config file like this:

```elixir
config :your_app, YourAppWeb.Endpoint,
  http: [
    ip: {127, 0, 0, 1},
    port: 4000,
    websocket_options: [primitive_ops_module: BanditNative.WebSocket]
  ],
```
