module format

fn format_number(@in string, out []u8, s u8) string {
	for i, j, k := @in.len - 1, out.len - 1, 0; true; i, j = i - 1, j - 1 {
		out[j] = @in[i]
		if i == 0 {
			return out.str()
		}
		if k == 3 {
			j, k = j - 1, 0
			out[j] = s
		}
	}
}
