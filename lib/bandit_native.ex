defmodule BanditNative do
  @moduledoc false

  use Rustler, otp_app: :bandit_native, crate: "bandit_native"

  @behaviour BanditNative.Behaviour

  @impl true
  def ws_mask(_data, _mask), do: :erlang.nif_error(:nif_not_loaded)
end
