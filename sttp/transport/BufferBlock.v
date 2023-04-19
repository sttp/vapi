module transport

import github.com.sttp.goapi.sttp.guid

struct BufferBlock {
mut:
	signal_id guid.Guid
	buffer    []u8
}
