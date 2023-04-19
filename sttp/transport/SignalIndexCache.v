module transport

import encoding.binary
import math
import github.com.sttp.goapi.sttp.guid
import github.com.sttp.goapi.sttp.hashset
import tssc

struct SignalIndexCache {
mut:
	reference      map[i32]u32
	signal_idlist  []guid.Guid
	source_list    []string
	id_list        []u64
	signal_idcache map[guid.Guid]i32
	binary_length  u32
	tssc_decoder   &tssc.Decoder
}

// NewSignalIndexCache makes a new SignalIndexC
pub fn new_signal_index_cache() &SignalIndexCache {
	return &SignalIndexCache{
		reference: map[i32]u32{}
		signal_idcache: map[guid.Guid]i32{}
	}
}

// addRecord adds a new record to the SignalIndexCache for provided key Measurement deta
fn (mut sic SignalIndexCache) add_record(ds &DataSubscriber, signalIndex i32, signalID guid.Guid, source string, id u64, charSizeEstimate u32) {
	mut index := u32(sic.signal_idlist.len)
	sic.reference[signalIndex] = index
	sic.signal_idlist << signalID
	sic.source_list << source
	sic.id_list << id
	sic.signal_idcache[signalID] = signalIndex
	mut metadata := ds.lookup_metadata(signalID)
	if metadata.source.len == 0 {
		metadata.source = source
		metadata.id = id
	}
	sic.binary_length += 32 + u32(source.len) * charSizeEstimate
}

// Contains determines if the specified signalIndex exists with the SignalIndexCa
pub fn (mut sic SignalIndexCache) contains(signalIndex_1 i32) bool {
	_, ok := sic.reference[signalIndex_1]
	return ok
}

// SignalID returns the signal ID Guid for the specified signalIndex in the SignalIndexCa
pub fn (mut sic SignalIndexCache) signal_id(signalIndex_2 i32) guid.Guid {
	mut index, ok := sic.reference[signalIndex_2]
	if ok {
		return sic.signal_idlist[index]
	}
	return guid.empty
}

// SignalIDs returns a HashSet for all the Guid values found in the SignalIndexCa
pub fn (mut sic SignalIndexCache) signal_ids() hashset.HashSet {
	return hashset.new_hash_set(sic.signal_idlist)
}

// Source returns the Measurement source string for the specified signalIndex in the SignalIndexCa
pub fn (mut sic SignalIndexCache) source_1(signalIndex_3 i32) string {
	mut index, ok := sic.reference[signalIndex_3]
	if ok {
		return sic.source_list[index]
	}
	return ''
}

// ID returns the Measurement integer ID for the specified signalIndex in the SignalIndexCa
pub fn (mut sic SignalIndexCache) id_1(signalIndex_4 i32) u64 {
	mut index, ok := sic.reference[signalIndex_4]
	if ok {
		return sic.id_list[index]
	}
	return math.max_uint64
}

// Record returns the key Measurement values, signalID Guid, source string, and integer ID a
pub fn (mut sic SignalIndexCache) record(signalIndex_5 i32) (guid.Guid, string, u64, bool) {
	mut index, ok := sic.reference[signalIndex_5]
	if ok {
		return sic.signal_idlist[index], sic.source_list[index], sic.id_list[index], true
	}
	return guid.empty, '', 0, false
}

// SignalIndex returns the signal index for the specified signalID Guid in the SignalIndexCa
pub fn (mut sic SignalIndexCache) signal_index(signalID_1 guid.Guid) i32 {
	mut index, ok := sic.signal_idcache[signalID_1]
	if ok {
		return index
	}
	return -1
}

// Count returns the number of Measurement records that can be found in the SignalIndexCa
pub fn (mut sic SignalIndexCache) count() u32 {
	return u32(sic.signal_idcache.len)
}

// BinaryLength gets the binary length, in bytes, for the SignalIndexCa
pub fn (mut sic SignalIndexCache) binary_length() u32 {
	return sic.binary_length
}

// decode parses a SignalIndexCache from the specified byte buffer received from a DataPublis
fn (mut sic SignalIndexCache) decode(ds_1 &DataSubscriber, buffer []u8, subscriberID &guid.Guid) error {
	mut length := u32(buffer.len)
	if length < 4 {
		return errors.new('not enough buffer provided to parse')
	}
	mut offset := u32(0)
	mut binary_length_1 := binary.big_endian.uint32(buffer)
	offset += 4
	if length < binary_length_1 {
		return errors.new('not enough buffer provided to parse')
	}
	mut err := error{}
	*subscriberID, err = guid.from_bytes(buffer[offset..], ds_1.swap_guid_endianness)
	if err != unsafe { nil } {
		return errors.new('failed to parse SubscriberID: ' + err.error())
	}
	offset += 16
	mut reference_count := binary.big_endian.uint32(buffer[offset..])
	offset += 4
	mut i := 0
	for i = 0; i < reference_count; i++ {
		mut signal_index_1 := i32(binary.big_endian.uint32(buffer[offset..]))
		offset += 4
		mut signal_id_1, err_1 := guid.from_bytes(buffer[offset..], ds_1.swap_guid_endianness)
		if err_1 != unsafe { nil } {
			return errors.new('failed to parse SignalID: ' + err_1.error())
		}
		offset += 16
		mut source_size := binary.big_endian.uint32(buffer[offset..])
		offset += 4
		mut source_3 := ds_1.decode_string(buffer[offset..offset + source_size])
		offset += source_size
		mut id_3 := binary.big_endian.uint64(buffer[offset..])
		offset += 8
		sic.add_record(ds_1, signal_index_1, signal_id_1, source_3, id_3, 1)
	}
	return unsafe { nil }
}
