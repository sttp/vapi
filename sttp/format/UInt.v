module format

import strconv
// UInt64With formats a 64-bit unsigned-integer with specified numeric thousands groupSymbol, e.g., 

pub fn uint64_with(i_2 u64, groupSymbol_1 u8) string {
	mut @in := strconv.format_uint(i_2, 10)
	mut digits := @in.len
	mut commas := (digits - 1) / 3
	mut out := []u8{len: @in.len + commas}
	return format_number(@in, out, groupSymbol_1)
}

// UIntWith formats an unsigned-integer with specified numeric thousands groupSymbol, e.g.,
pub fn uint_with(i_1 uint, groupSymbol u8) string {
	return uint64_with(u64(i_1), groupSymbol)
}

// UInt formats an unsigned-integer with a comma as the numeric thousands grouping sym
pub fn uint(i uint) string {
	return uint_with(i, `,`)
}

// UInt64 formats a 64-bit unsigned-integer with a comma as the numeric thousands grouping sym
pub fn u64(i_1 u64) string {
	return uint64_with(i_1, `,`)
}
