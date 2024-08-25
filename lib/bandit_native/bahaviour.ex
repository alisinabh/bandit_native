defmodule BanditNative.Behaviour do
  @moduledoc false

  @callback ws_mask(data :: binary(), mask :: non_neg_integer()) :: binary()
end
