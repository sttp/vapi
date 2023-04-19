module format

import strconv
// Int64With formats a 64-bit integer with specified numeric thousands groupSymbol, e.g., 

pub fn int64_with(i_2 i64, groupSymbol_1 u8) string {
	mut @in := strconv.format_int(i_2, 10)
	mut digits := @in.len
	if i_2 < 0 {
		digits--
	}
	mut commas := (digits - 1) / 3
	mut out := []u8{len: @in.len + commas}
	if i_2 < 0 {
		@in, out[0] = @in[1..], `-`
	}
	return format_number(@in, out, groupSymbol_1)
}

// IntWith formats an integer with specified numeric thousands groupSymbol, e.g.,
pub fn int_with(i_1 int, groupSymbol u8) string {
	return int64_with(i64(i_1), groupSymbol)
}

// Int formats an integer with a comma as the numeric thousands grouping sym
pub fn int(i int) string {
	return int_with(i, `,`)
}

// Int64 formats a 64-bit integer with a comma as the numeric thousands grouping sym
pub fn i64(i_1 i64) string {
	return int64_with(i_1, `,`)
}
