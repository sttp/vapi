module transport

struct SubscriptionInfo {
mut:
	filter_expression                  string
	throttled                          bool
	publish_interval                   f64
	udp_data_channel                   bool
	data_channel_local_port            u16
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
