module transport

struct SubscriberConnection {
mut:
	encoding OperationalEncodingEnum
}

// EncodeString encodes an STTP string according to the defined operational mo
pub fn (mut sc SubscriberConnection) encode_string(value string) []u8 {
	if sc.encoding != operational_encoding.utf8 {
		panic('Go implementation of STTP only supports UTF8 string encoding')
	}
	return value.bytes()
}
