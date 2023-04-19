module transport

import strconv
import time
import github.com.sttp.goapi.sttp.guid
import github.com.sttp.goapi.sttp.ticks

struct Measurement {
mut:
	signal_id guid.Guid
	value     f64
	timestamp ticks.Ticks
	flags     StateFlagsEnum
}

// TimestampValue gets the integer-based time from a `Measurement` ticks-based timestamp, i
pub fn (mut m Measurement) timestamp_value() i64 {
	return m.timestamp.timestamp_value()
}

// DateTime gets Measurement ticks-based timestamp as a standard Go Time va
pub fn (mut m Measurement) date_time() time.Time {
	return m.timestamp.to_time()
}

// String returns the string form of a Measurement va
pub fn (mut m Measurement) string() string {
	return strconv.v_sprintf('%s @ %s = %s (%s)', m.signal_id.string(), m.timestamp.short_time(),
		strconv.format_float(m.value, `f`, 3, 64), m.flags.string())
}
