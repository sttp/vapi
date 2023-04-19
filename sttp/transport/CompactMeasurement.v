module transport

import encoding.binary
import math
import github.com.sttp.goapi.sttp.ticks

const (
	compact_state_flags   = NOT_YET_IMPLEMENTED
	data_range_mask       = StateFlagsEnum(0x000000FC)
	data_quality_mask     = StateFlagsEnum(0x0000EF03)
	time_quality_mask     = StateFlagsEnum(0x00BF0000)
	system_issue_mask     = StateFlagsEnum(0xE0000000)
	calculated_value_mask = StateFlagsEnum(0x00001000)
	discarded_value_mask  = StateFlagsEnum(0x00400000)
	fixed_length          = 9
)

type CompactStateFlagsEnum = u8

struct Go2VInlineStruct {
mut:
	data_range       CompactStateFlagsEnum
	data_quality     CompactStateFlagsEnum
	time_quality     CompactStateFlagsEnum
	system_issue     CompactStateFlagsEnum
	calculated_value CompactStateFlagsEnum
	discarded_value  CompactStateFlagsEnum
	base_time_offset CompactStateFlagsEnum
	time_index       CompactStateFlagsEnum
}

struct CompactMeasurement {
	Measurement
mut:
	signal_index_cache         &SignalIndexCache
	base_time_offsets          [2]i64
	include_time               bool
	use_millisecond_resolution bool
	time_index                 i32
	using_base_time_offset     bool
}

fn (mut compactFlags CompactStateFlagsEnum) map_to_full_flags() StateFlagsEnum {
	mut full_flags := StateFlagsEnum{}
	if (compact_flags & transport.compact_state_flags.data_range) > 0 {
		full_flags |= transport.data_range_mask
	}
	if (compact_flags & transport.compact_state_flags.data_quality) > 0 {
		full_flags |= transport.data_quality_mask
	}
	if (compact_flags & transport.compact_state_flags.time_quality) > 0 {
		full_flags |= transport.time_quality_mask
	}
	if (compact_flags & transport.compact_state_flags.system_issue) > 0 {
		full_flags |= transport.system_issue_mask
	}
	if (compact_flags & transport.compact_state_flags.calculated_value) > 0 {
		full_flags |= transport.calculated_value_mask
	}
	if (compact_flags & transport.compact_state_flags.discarded_value) > 0 {
		full_flags |= transport.discarded_value_mask
	}
	return full_flags
}

fn (mut fullFlags StateFlagsEnum) map_to_compact_flags() CompactStateFlagsEnum {
	mut compact_flags := CompactStateFlagsEnum{}
	if (full_flags & transport.data_range_mask) > 0 {
		compact_flags |= transport.compact_state_flags.data_range
	}
	if (full_flags & transport.data_quality_mask) > 0 {
		compact_flags |= transport.compact_state_flags.data_quality
	}
	if (full_flags & transport.time_quality_mask) > 0 {
		compact_flags |= transport.compact_state_flags.time_quality
	}
	if (full_flags & transport.system_issue_mask) > 0 {
		compact_flags |= transport.compact_state_flags.system_issue
	}
	if (full_flags & transport.calculated_value_mask) > 0 {
		compact_flags |= transport.compact_state_flags.calculated_value
	}
	if (full_flags & transport.discarded_value_mask) > 0 {
		compact_flags |= transport.compact_state_flags.discarded_value
	}
	return compact_flags
}

// NewCompactMeasurement creates a new CompactMeasure
pub fn new_compact_measurement(signalIndexCache &SignalIndexCache, includeTime bool, baseTimeOffsets [2]i64) CompactMeasurement {
	return CompactMeasurement{
		measurement: Measurement{}
		signalIndexCache: signalIndexCache
		baseTimeOffsets: baseTimeOffsets
		includeTime: includeTime
		use_millisecond_resolution: use_millisecond_resolution
		time_index: 0
		using_base_time_offset: false
	}
}

// GetBinaryLength gets the binary byte length of a CompactMeasure
pub fn (mut cm CompactMeasurement) get_binary_length() u32 {
	mut length := u32(transport.fixed_length)
	if !cm.include_time {
		return length
	}
	mut base_time_offset := cm.base_time_offsets[cm.time_index]
	if base_time_offset > 0 {
		mut difference := cm.ticks_value() - base_time_offset
		if difference > 0 {
			if cm.use_millisecond_resolution {
				cm.using_base_time_offset = difference / i64(ticks.per_millisecond) < math.max_uint16
			} else {
				cm.using_base_time_offset = difference < math.max_uint32
			}
		} else {
			cm.using_base_time_offset = false
		}
		if cm.using_base_time_offset {
			if cm.use_millisecond_resolution {
				length += 2
			} else {
				length += 4
			}
		} else {
			length += 8
		}
	} else {
		length += 8
	}
	return length
}

// GetTimestampC2 gets offset compressed millisecond-resolution 2-byte timest
pub fn (mut cm CompactMeasurement) get_timestamp_c2() u16 {
	return u16((cm.ticks_value() - cm.base_time_offsets[cm.time_index]) / i64(ticks.per_millisecond))
}

// GetTimestampC4 gets offset compressed tick-resolution 4-byte timest
pub fn (mut cm CompactMeasurement) get_timestamp_c4() u32 {
	return u32(cm.ticks_value() - cm.base_time_offsets[cm.time_index])
}

// GetCompactStateFlags gets byte level compact state flags with encoded time index and base time offset b
pub fn (mut cm CompactMeasurement) get_compact_state_flags() u8 {
	mut flags := cm.flags.map_to_compact_flags()
	if cm.time_index != 0 {
		flags |= transport.compact_state_flags.time_index
	}
	if cm.using_base_time_offset {
		flags |= transport.compact_state_flags.base_time_offset
	}
	return u8(flags)
}

// SetCompactStateFlags sets byte level compact state flags with encoded time index and base time offset b
pub fn (mut cm CompactMeasurement) set_compact_state_flags(value u8) {
	mut flags := CompactStateFlagsEnum(value)
	cm.flags = flags.map_to_full_flags()
	if (flags & transport.compact_state_flags.time_index) > 0 {
		cm.time_index = 1
	} else {
		cm.time_index = 0
	}
	cm.using_base_time_offset = (flags & transport.compact_state_flags.base_time_offset) > 0
}

// GetRuntimeID gets the 4-byte run-time signal index for this measurem
pub fn (mut cm CompactMeasurement) get_runtime_id() i32 {
	return cm.signal_index_cache.signal_index(cm.signal_id)
}

// SetRuntimeID assigns CompactMeasurement SignalID (UUID) from the specified signalIn
pub fn (mut cm CompactMeasurement) set_runtime_id(signalIndex i32) {
	cm.signal_id = cm.signal_index_cache.signal_id(signalIndex)
}

// Decode parses a CompactMeasurement from the specified byte buf
pub fn (mut cm CompactMeasurement) decode(buffer []u8) (int, error) {
	if buffer.len < transport.fixed_length {
		return 0, errors.new('not enough buffer available to deserialize compact measurement')
	}
	mut index := 0
	cm.set_compact_state_flags(buffer[0])
	index++
	cm.set_runtime_id(i32(binary.big_endian.uint32(buffer[index..])))
	index += 4
	cm.value = f64(math.float32frombits(binary.big_endian.uint32(buffer[index..])))
	index += 4
	if !cm.include_time {
		return index, unsafe { nil }
	}
	if cm.using_base_time_offset {
		mut base_time_offset := cm.base_time_offsets[cm.time_index]
		if cm.use_millisecond_resolution {
			if base_time_offset > 0 {
				cm.timestamp = ticks.ticks(base_time_offset +
					i64(binary.big_endian.uint16(buffer[index..])) * i64(ticks.per_millisecond))
			}
			index += 2
		} else {
			if base_time_offset > 0 {
				cm.timestamp = ticks.ticks(base_time_offset +
					i64(binary.big_endian.uint32(buffer[index..])))
			}
			index += 4
		}
	} else {
		cm.timestamp = ticks.ticks(binary.big_endian.uint64(buffer[index..]))
		index += 8
	}
	return index, unsafe { nil }
}
