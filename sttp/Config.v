module sttp

const config_defaults = Config{
	max_retries: -1
	retry_interval: 1000
	max_retry_interval: 30000
	auto_reconnect: true
	auto_request_metadata: true
	auto_subscribe: true
	compress_payload_data: true
	compress_metadata: true
	compress_signal_index_cache: true
	version: 2
	rfc_guid_encoding: true
}

struct Config {
mut:
	max_retries                 i32
	retry_interval              i32
	max_retry_interval          i32
	auto_reconnect              bool
	auto_request_metadata       bool
	auto_subscribe              bool
	compress_payload_data       bool
	compress_metadata           bool
	compress_signal_index_cache bool
	metadata_filters            string
	version                     u8
	rfc_guid_encoding           bool
}

// NewConfig creates a new Config instance initialzed with default val
pub fn new_config() &Config {
	mut config := sttp.config_defaults
	return &config
}
