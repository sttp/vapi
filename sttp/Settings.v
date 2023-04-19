module sttp

const settings_defaults = Settings{
	publish_interval: 1.0
	include_time: true
	processing_interval: -1
	lag_time: 10.0
	lead_time: 5.0
}

struct Settings {
mut:
	throttled                          bool
	publish_interval                   f64
	udp_port                           u16
	include_time                       bool
	enable_time_reasonability_check    bool
	lag_time                           f64
	lead_time                          f64
	use_local_clock_as_real_time       bool
	use_millisecond_resolution         bool
	request_na_nvalue_filter           bool
	start_time                         string
	stop_time                          string
	constraint_parameters              string
	processing_interval                i32
	extra_connection_string_parameters string
}

// NewSettings creates a new Settings instance initialized with default val
pub fn new_settings() &Settings {
	mut settings := sttp.settings_defaults
	return &settings
}
