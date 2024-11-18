use rustler::env::Env;
use rustler::NifResult;
use rustler::{Binary, NewBinary};

const MASK_LEN: usize = std::mem::size_of::<u32>();

#[rustler::nif]
fn ws_mask<'a>(env: Env<'a>, data: Binary<'a>, mask_value: u32) -> NifResult<Binary<'a>> {
    let mut out = NewBinary::new(env, data.len());

    // Process each complete 4-byte chunk
    for (chunk, out_chunk) in data
        .chunks_exact(MASK_LEN)
        .zip(out.chunks_exact_mut(MASK_LEN))
    {
        let num = u32::from_be_bytes(chunk.try_into().unwrap());
        out_chunk.copy_from_slice(&(num ^ mask_value).to_be_bytes());
    }

    // Handle any leftover bytes that don't fit into a chunk of 4
    let remainder = data.len() % MASK_LEN;
    if remainder != 0 {
        let mask_bytes = mask_value.to_be_bytes();
        let offset = data.len() - remainder;
        for (i, out_byte) in out.as_mut_slice()[offset..].iter_mut().enumerate() {
            *out_byte = data[offset + i] ^ mask_bytes[i];
        }
    }

    Ok(out.into())
}

rustler::init!("Elixir.BanditNative.WebSocket");
