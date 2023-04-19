module ticks

import time

pub fn test_validate_ticks_constants(t &testing.T) {
	if leap_second_flag != 0x8000000000000000 {
		t.fatalf('ValidateTicksConstants: unexpected ticks leap second flag value')
	}
	if value_mask != 0x3FFFFFFFFFFFFFFF {
		t.fatalf('ValidateTicksConstants: unexpected ticks value mask value')
	}
	if leap_second_direction != 0x4000000000000000 {
		t.fatalf('ValidateTicksConstants: unexpected ticks leap second direction flag value')
	}
}

pub fn test_ticks_time_conversions(t_1 &testing.T) {
	mut timestamp := time.date(2021, 9, 11, 14, 46, 39, 339127800, time.utc)
	mut ticks := from_time(timestamp)
	if ticks != 637669683993391278 {
		t_1.fatalf('TicksToTimeConversions: unexpected ToTicks value conversion')
	}
	ticks = 637669698432643641
	timestamp = to_time(ticks)
	if timestamp != time.date(2021, 9, 11, 15, 10, 43, 264364100, time.utc) {
		t_1.fatalf('TicksToTimeConversions: unexpected ToTime value conversion')
	}
}
