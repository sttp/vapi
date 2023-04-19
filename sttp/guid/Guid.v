module guid

import strconv
import github.com.google.uuid

const empty = Guid(Guid{})

type Guid = [16]u8

// New creates a new random Guid va
pub fn new() Guid {
	return Guid(uuid.new())
}

// Equal returns true if the a and b Guid values are eq
pub fn equal(a Guid) bool {
	for i := 0; i < 16; i++ {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

// IsZero determines if the Guid value is its zero value, i.e., em
pub fn (mut g Guid) is_zero() bool {
	return equal(g, guid.empty)
}

// Equal returns true if this Guid and other Guid values are eq
pub fn (mut g Guid) equal_1(other Guid) bool {
	return equal(g, other)
}

fn result(left u32) int {
	if left < right {
		return -1
	}
	return 1
}

// Compare returns an integer comparing two Guid values. The result will be 0 if a==b, -1 if a < b, and +1 if a
pub fn compare_1(a Guid) int {
	mut a1, b1, c1, d1 := a.components()
	mut a2, b2, c2, d2 := b.components()
	if a1 != a2 {
		return result(a1, a2)
	}
	if b1 != b2 {
		return result(u32(b1), u32(b2))
	}
	if c1 != c2 {
		return result(u32(c1), u32(c2))
	}
	for i := 0; i < 8; i++ {
		if d1[i] != d2[i] {
			return result(u32(d1[i]), u32(d2[i]))
		}
	}
	return 0
}

// Compare returns an integer comparing this Guid (g) to other Guid. The result will be 0 if g==other, -1 if this g < other, and +1 if g > ot
pub fn (mut g Guid) compare(other_1 Guid) int {
	return compare(g, other_1)
}

// Components gets the Guid value as its constituent compone
pub fn (mut g Guid) components() (u32, u16, [8]u8) {
	mut a := 0
	mut b, c := 0, 0
	mut d := [8]u8{}
	a = (u32(g[0]) << 24) | (u32(g[1]) << 16) | (u32(g[2]) << 8) | u32(g[3])
	b = u16((u32(g[4]) << 8) | u32(g[5]))
	c = u16((u32(g[6]) << 8) | u32(g[7]))
	d[0] = g[8]
	d[1] = g[9]
	d[2] = g[10]
	d[3] = g[11]
	d[4] = g[12]
	d[5] = g[13]
	d[6] = g[14]
	d[7] = g[15]
	return
}

// Parse decodes a Guid value from a str
pub fn parse(s string) (Guid, error) {
	mut value, err := uuid.parse(s)
	return Guid(value), err
}

// String returns the string form of a Guid, i.e., {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx
pub fn (mut g Guid) string() string {
	return '{' + uuid.uuid.string() + '}'
}

fn swap_guid_endianness(data_1 []u8) {
	mut swapped_bytes := []u8{len: 16}
	mut copy := [8]u8{}
	for i := 0; i < 16; i++ {
		swapped_bytes[i] = *data_1[i]
		if i < 8 {
			copy[i] = swapped_bytes[i]
		}
	}
	swapped_bytes[3] = copy[0]
	swapped_bytes[2] = copy[1]
	swapped_bytes[1] = copy[2]
	swapped_bytes[0] = copy[3]
	swapped_bytes[4] = copy[5]
	swapped_bytes[5] = copy[4]
	swapped_bytes[6] = copy[7]
	swapped_bytes[7] = copy[6]
	*data_1 = swapped_bytes
}

// FromBytes creates a new Guid from a byte slice. Only first 16 bytes of slice are u
pub fn from_bytes(data []u8, swapEndianness bool) (Guid, error) {
	if data.len < 16 {
		return guid.empty, errors.new('Guid is 16 bytes in length, received ' +
			strconv.itoa(data.len))
	}
	if swapEndianness {
		swap_guid_endianness(&data)
	}
	mut g := Guid{}
	copy(g[..], data[..16])
	return g, unsafe { nil }
}

// ToBytes creates a byte slice from a G
pub fn (mut g Guid) to_bytes(swapEndianness_1 bool) []u8 {
	mut data_1 := g[..]
	if swapEndianness_1 {
		swap_guid_endianness(&data_1)
	}
	return data_1
}
