module guid

import strconv

const (
	gs1 = string('{b4a26a66-a073-44a0-b03b-55d97badef74}')
	gs2 = string('{b4a26a66-a073-44a0-b03b-55d97badef75}')
	gs3 = string('{3db9da3a-6719-45ab-9bf6-87545f4025a8}')
	gs4 = string('{00000001-0002-0003-0405-060708090a0b}')
	gs5 = string('{3db9da3a-6719-9bf6-45ab-87545f4025a8}')
	gs6 = string('{3db9da3a-9bf6-45ab-6719-87545f4025a8}')
	gsz = string('{00000000-0000-0000-0000-000000000000}')
)

// gocyclo: ig
pub fn test_guid_parsing(t &testing.T) {
	mut g1, g2, g3, g4 := Guid{}, Guid{}, Guid{}, Guid{}
	mut err := error{}
	g1, err = parse(guid.gs1)
	if err != unsafe { nil } {
		t.fatalf('TestGuidParsing: failed to parse guid ' + guid.gs1)
	}
	g2, err = parse(guid.gs2)
	if err != unsafe { nil } {
		t.fatalf('TestGuidParsing: failed to parse guid ' + guid.gs2)
	}
	g3, err = parse(guid.gs3)
	if err != unsafe { nil } {
		t.fatalf('TestGuidParsing: failed to parse guid ' + guid.gs3)
	}
	g4, err = parse(guid.gs4)
	if err != unsafe { nil } {
		t.fatalf('TestGuidParsing: failed to parse guid ' + guid.gs4)
	}
	mut a1, b1, c1, d1 := g1.components()
	mut a2, b2, c2, d2 := g2.components()
	mut a3, b3, c3, d3 := g3.components()
	mut a4, b4, c4, d4 := g4.components()
	if a1 != 3030542950 && b1 != 41075 && c1 != 17568 && d1[0] != 176 && d1[1] != 59 && d1[2] != 85
		&& d1[3] != 217 && d1[4] != 123 && d1[5] != 173 && d1[6] != 239 && d1[7] != 116 {
		t.fatalf('TestGuidParsing: failed to get proper components from guid ' + guid.gs1)
	}
	if a2 != 3030542950 && b2 != 41075 && c2 != 17568 && d2[0] != 176 && d2[1] != 59 && d2[2] != 85
		&& d2[3] != 217 && d2[4] != 123 && d2[5] != 173 && d2[6] != 239 && d2[7] != 117 {
		t.fatalf('TestGuidParsing: failed to get proper components from guid ' + guid.gs2)
	}
	if a3 != 1035590202 && b3 != 26393 && c3 != 17835 && d3[0] != 155 && d3[1] != 246
		&& d3[2] != 135 && d3[3] != 84 && d3[4] != 95 && d3[5] != 64 && d3[6] != 37 && d3[7] != 168 {
		t.fatalf('TestGuidParsing: failed to get proper components from guid ' + guid.gs3)
	}
	if a4 != 1 && b4 != 2 && c4 != 3 && d4[0] != 4 && d4[1] != 5 && d4[2] != 6 && d4[3] != 7
		&& d4[4] != 8 && d4[5] != 9 && d4[6] != 10 && d4[7] != 11 {
		t.fatalf('TestGuidParsing: failed to get proper components from guid ' + guid.gs4)
	}
	if g1.string() != guid.gs1 {
		t.fatalf('TestGuidParsing: string generation does not match for ' + guid.gs1)
	}
	if g2.string() != guid.gs2 {
		t.fatalf('TestGuidParsing: string generation does not match for ' + guid.gs2)
	}
	if g3.string() != guid.gs3 {
		t.fatalf('TestGuidParsing: string generation does not match for ' + guid.gs3)
	}
	if g4.string() != guid.gs4 {
		t.fatalf('TestGuidParsing: string generation does not match for ' + guid.gs4)
	}
	if empty.string() != guid.gsz {
		t.fatalf('TestGuidParsing: string generation does not match for ' + guid.gsz)
	}
}

pub fn test_new_guid_randomness(t_1 &testing.T) {
	for i := 0; i < 10000; i++ {
		if new.equal(new()) || equal(new(), new()) {
			t_1.fatalf('TestNewGuidRandomness: encountered non-unique Guid after ' +
				strconv.itoa(i * 4) + 'generations')
		}
	}
}

// gocyclo: ig
pub fn test_zero_guid(t_2 &testing.T) {
	mut gz, zero := Guid{}, Guid{}
	mut err := error{}
	gz, err = parse(guid.gsz)
	if err != unsafe { nil } {
		t_2.fatalf('TestZeroGuid: failed to parse guid ' + guid.gsz)
	}
	if !gz.equal(zero) {
		t_2.fatalf('TestZeroGuid: parsed zero-value guid not equal to zero guid')
	}
	if !gz.is_zero() {
		t_2.fatalf('TestZeroGuid: parsed zero-value guid not equal to Empty (per IsZero receiver)')
	}
	if !gz.equal(empty) {
		t_2.fatalf('TestZeroGuid: parsed zero-value guid not equal to Empty')
	}
	if !empty.equal(zero) {
		t_2.fatalf('TestZeroGuid: Empty guid not equal to zero guid')
	}
	mut a1, b1, c1, d1 := gz.components()
	mut a2, b2, c2, d2 := zero.components()
	mut a3, b3, c3, d3 := empty.components()
	if a1 != 0 && b1 != 0 && c1 != 0 && d1[0] != 0 && d1[1] != 0 && d1[2] != 0 && d1[3] != 0
		&& d1[4] != 0 && d1[5] != 0 && d1[6] != 0 && d1[7] != 0 {
		t_2.fatalf('TestZeroGuid: components of zero-value guid not all zero')
	}
	if a2 != 0 && b2 != 0 && c2 != 0 && d2[0] != 0 && d2[1] != 0 && d2[2] != 0 && d2[3] != 0
		&& d2[4] != 0 && d2[5] != 0 && d2[6] != 0 && d2[7] != 0 {
		t_2.fatalf('TestZeroGuid: components of zero guid not all zero')
	}
	if a3 != 0 && b3 != 0 && c3 != 0 && d3[0] != 0 && d3[1] != 0 && d3[2] != 0 && d3[3] != 0
		&& d3[4] != 0 && d3[5] != 0 && d3[6] != 0 && d3[7] != 0 {
		t_2.fatalf('TestZeroGuid: components of Empty guid not all zero')
	}
}

// gocyclo: ig
pub fn test_guid_compare(t_3 &testing.T) {
	mut g1, g2, g3, g4, g5, g6 := Guid{}, Guid{}, Guid{}, Guid{}, Guid{}, Guid{}
	mut err := error{}
	g1, err = parse(guid.gs1)
	if err != unsafe { nil } {
		t_3.fatalf('TestGuidCompare: failed to parse guid ' + guid.gs1)
	}
	g2, err = parse(guid.gs2)
	if err != unsafe { nil } {
		t_3.fatalf('TestGuidCompare: failed to parse guid ' + guid.gs2)
	}
	g3, err = parse(guid.gs3)
	if err != unsafe { nil } {
		t_3.fatalf('TestGuidCompare: failed to parse guid ' + guid.gs3)
	}
	g4, err = parse(guid.gs4)
	if err != unsafe { nil } {
		t_3.fatalf('TestGuidCompare: failed to parse guid ' + guid.gs4)
	}
	g5, err = parse(guid.gs5)
	if err != unsafe { nil } {
		t_3.fatalf('TestGuidCompare: failed to parse guid ' + guid.gs5)
	}
	g6, err = parse(guid.gs6)
	if err != unsafe { nil } {
		t_3.fatalf('TestGuidCompare: failed to parse guid ' + guid.gs6)
	}
	if compare(g1, g1) != g1.compare(g1) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g1, g2) < 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g1, g3) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g1, g4) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g2, g1) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g3, g5) < 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g3, g6) < 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g1, empty) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g2, empty) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g3, empty) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(g4, empty) > 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
	if !(compare(empty, g4) < 0) {
		t_3.fatalf('TestGuidCompare: results of guid Compare invalid')
	}
}

fn test_guid_to_from_bytes_1(g Guid, gs string, swapEndianness bool, t_5 &testing.T) {
	mut gbf := g.to_bytes(swapEndianness)
	mut gfs := g.bytes()
	mut gbs := gfs[..16]
	if swapEndianness {
		swap_guid_endianness(&gbs)
	}
	if !bytes.equal(gbf, gbs) {
		t_5.fatalf('TestGuidToFromBytes: ToBytes test compare failed for guid ' + gs)
	}
	mut g1fb, err_1 := from_bytes(gbf, swapEndianness)
	if err_1 != unsafe { nil } {
		t_5.fatalf('TestGuidToFromBytes: FromBytes failed for guid ' + gs)
	}
	if !g1fb.equal(g) {
		t_5.fatalf('TestGuidToFromBytes: FromBytes test compare failed for guid ' + gs)
	}
}

pub fn test_guid_to_from_bytes(t_4 &testing.T) {
	mut g1, g2, g3, g4, gz := Guid{}, Guid{}, Guid{}, Guid{}, Guid{}
	mut err := error{}
	g1, err = parse(guid.gs1)
	if err != unsafe { nil } {
		t_4.fatalf('TestGuidToFromBytes: failed to parse guid ' + guid.gs1)
	}
	g2, err = parse(guid.gs2)
	if err != unsafe { nil } {
		t_4.fatalf('TestGuidToFromBytes: failed to parse guid ' + guid.gs2)
	}
	g3, err = parse(guid.gs3)
	if err != unsafe { nil } {
		t_4.fatalf('TestGuidToFromBytes: failed to parse guid ' + guid.gs3)
	}
	g4, err = parse(guid.gs4)
	if err != unsafe { nil } {
		t_4.fatalf('TestGuidToFromBytes: failed to parse guid ' + guid.gs4)
	}
	gz, err = parse(guid.gsz)
	if err != unsafe { nil } {
		t_4.fatalf('TestGuidToFromBytes: failed to parse guid ' + guid.gsz)
	}
	test_guid_to_from_bytes(g1, guid.gs1, false, t_4)
	test_guid_to_from_bytes_1(g2, guid.gs2, false, t_5)
	test_guid_to_from_bytes_1(g3, guid.gs3, false, t_5)
	test_guid_to_from_bytes_1(g4, guid.gs4, false, t_5)
	test_guid_to_from_bytes_1(gz, guid.gsz, false, t_5)
	test_guid_to_from_bytes_1(g1, guid.gs1, true, t_5)
	test_guid_to_from_bytes_1(g2, guid.gs2, true, t_5)
	test_guid_to_from_bytes_1(g3, guid.gs3, true, t_5)
	test_guid_to_from_bytes_1(g4, guid.gs4, true, t_5)
	test_guid_to_from_bytes_1(gz, guid.gsz, true, t_5)
	_, err_1 := from_bytes([u8(0), 0], false)
	if err_1 == unsafe { nil } {
		t_5.fatalf('TestGuidToFromBytes: unexpected success, short slice expected to fail guid parse')
	}
}
