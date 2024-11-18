defmodule BanditNativeTest do
  use ExUnit.Case
  alias BanditNative.WebSocket
  doctest WebSocket

  describe "ws_mask/2" do
    test "mask values like reference implementation" do
      for _i <- 1..1000 do
        payload = :rand.bytes(Enum.random(1..999_999))
        mask = :rand.uniform(0xFFFFFFFF)

        assert WebSocket.ws_mask(payload, mask) ==
                 BanditNative.ReferenceImpl.ws_mask(payload, mask)
      end
    end

    test "mask is involution (unmask = mask again)" do
      for _i <- 1..1000 do
        payload = :rand.bytes(Enum.random(1..999_999))
        mask = :rand.uniform(0xFFFFFFFF)

        masked_payload = WebSocket.ws_mask(payload, mask)

        assert WebSocket.ws_mask(masked_payload, mask) == payload
      end
    end
  end
end
