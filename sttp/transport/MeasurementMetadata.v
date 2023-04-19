module transport

import strconv
import strings
import time
import github.com.sttp.goapi.sttp.guid

struct MeasurementMetadata {
mut:
	signal_id        guid.Guid
	adder            f64
	multiplier       f64
	id               u64
	source           string
	signal_type      string
	signal_reference string
	description      string
	updated_on       time.Time
	tag              string
}

// ParseSignalReference attempts to parse a normally formatted signal reference in
pub fn (mut mm MeasurementMetadata) parse_signal_reference() (string, SignalKindEnum, int) {
	mut source := ''
	mut signal_kind := SignalKindEnum{}
	mut position := 0
	mut signal_reference := mm.signal_reference
	mut parts := signal_reference.split('-')
	if parts.len > 1 {
		mut last_index := parts.len - 1
		mut type_info := parts[last_index]
		signal_kind = parse_signal_kind_acronym(type_info[..2])
		position, _ = strconv.atoi(type_info[2..])
		source = strings.join(parts[..last_index], '-')
	}
	return
}
