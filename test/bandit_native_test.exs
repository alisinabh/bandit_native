defmodule BanditNativeTest do
  use ExUnit.Case
  doctest BanditNative

  describe "ws_mask/2" do
    test "mask values like reference implementation" do
      for len <- 1..100 do
        payload = :rand.bytes(len)
        mask = :rand.uniform(0xFFFFFFFF)

        assert BanditNative.ws_mask(payload, mask) ==
                 BanditNative.ReferenceImpl.ws_mask(payload, mask)
      end
    end

    test "mask is involution (unmask = mask again)" do
      for len <- 1..100 do
        payload = :rand.bytes(len)
        mask = :rand.uniform(0xFFFFFFFF)

        masked_payload = BanditNative.ws_mask(payload, mask)

        assert BanditNative.ws_mask(masked_payload, mask) == payload
      end
    end
  end
end
