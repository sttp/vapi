module format

import strconv
import strings
// FloatWith formats a floating-point number with the specified decimalSymbol, e.g., 

pub fn float_with(f_1 f64, prec_1 int, decimalSymbol u8) string {
	mut @in := strconv.format_float(f_1, `f`, prec_1, 64)
	mut dec_symbol_as_str := [u8(decimalSymbol)].str()
	if decimalSymbol != `.` {
		@in = strings.replace(@in, '.', dec_symbol_as_str, 1)
	}
	mut parts := @in.split(dec_symbol_as_str)
	mut fraction := ''
	if parts.len > 1 {
		@in = parts[0]
		fraction = dec_symbol_as_str + parts[1]
	}
	mut digits := @in.len
	if f_1 < 0 {
		digits--
	}
	mut commas := (digits - 1) / 3
	mut out := []u8{len: @in.len + commas}
	if f_1 < 0 {
		@in, out[0] = @in[1..], `-`
	}
	return format_number(@in, out, group_symbol) + fraction
}

// Float formats a floating-point number with a period as the decimal symbol and a comm
pub fn float(f f64, prec int) string {
	return float_with(f, prec, `.`, `,`)
}
