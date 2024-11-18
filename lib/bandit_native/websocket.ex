defmodule BanditNative.WebSocket do
  @moduledoc """
  WebSocket PrimitiveOps implementation for Bandit using an Erlang NIF
  """

  use Rustler, otp_app: :bandit_native, crate: "bandit_native"

  @behaviour Bandit.PrimitiveOps.WebSocket

  @impl true
  def ws_mask(_data, _mask), do: :erlang.nif_error(:nif_not_loaded)
end
