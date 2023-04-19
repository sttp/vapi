module transport

import strconv
import strings

const (
	max_packet_size                = 32768
	payload_header_size            = 4
	response_header_size           = 6
	even_key                       = 0
	odd_key                        = 1
	key_index                      = 0
	iv_index                       = 1
	missing_cache_warning_interval = 20000000
	default_lag_time               = 5.0
	default_lead_time              = 5.0
	default_publish_interval       = 1.0
	state_flags                    = NOT_YET_IMPLEMENTED
	data_packet_flags              = NOT_YET_IMPLEMENTED
	server_command                 = NOT_YET_IMPLEMENTED
	server_response                = NOT_YET_IMPLEMENTED
	operational_modes              = NOT_YET_IMPLEMENTED
	operational_encoding           = NOT_YET_IMPLEMENTED
	compression_modes              = NOT_YET_IMPLEMENTED
	security_mode                  = NOT_YET_IMPLEMENTED
	connect_status                 = NOT_YET_IMPLEMENTED
)

type StateFlagsEnum = u32
type DataPacketFlagsEnum = u8
type ServerCommandEnum = u8
type ServerResponseEnum = u8
type OperationalModesEnum = u32
type OperationalEncodingEnum = u32
type CompressionModesEnum = u32
type SecurityModeEnum = int
type ConnectStatusEnum = int

struct Go2VInlineStruct {
mut:
	normal                StateFlagsEnum
	bad_data              StateFlagsEnum
	suspect_data          StateFlagsEnum
	over_range_error      StateFlagsEnum
	under_range_error     StateFlagsEnum
	alarm_high            StateFlagsEnum
	alarm_low             StateFlagsEnum
	warning_high          StateFlagsEnum
	warning_low           StateFlagsEnum
	flatline_alarm        StateFlagsEnum
	comparison_alarm      StateFlagsEnum
	rocalarm              StateFlagsEnum
	received_as_bad       StateFlagsEnum
	calculated_value      StateFlagsEnum
	calculation_error     StateFlagsEnum
	calculation_warning   StateFlagsEnum
	reserved_quality_flag StateFlagsEnum
	bad_time              StateFlagsEnum
	suspect_time          StateFlagsEnum
	late_time_alarm       StateFlagsEnum
	future_time_alarm     StateFlagsEnum
	up_sampled            StateFlagsEnum
	down_sampled          StateFlagsEnum
	discarded_value       StateFlagsEnum
	reserved_time_flag    StateFlagsEnum
	user_defined_flag1    StateFlagsEnum
	user_defined_flag2    StateFlagsEnum
	user_defined_flag3    StateFlagsEnum
	user_defined_flag4    StateFlagsEnum
	user_defined_flag5    StateFlagsEnum
	system_error          StateFlagsEnum
	system_warning        StateFlagsEnum
	measurement_error     StateFlagsEnum
}

struct Go2VInlineStruct_1 {
mut:
	compact      DataPacketFlagsEnum
	cipher_index DataPacketFlagsEnum
	compressed   DataPacketFlagsEnum
	cache_index  DataPacketFlagsEnum
	no_flags     DataPacketFlagsEnum
}

struct Go2VInlineStruct_2 {
mut:
	connect                    ServerCommandEnum
	metadata_refresh           ServerCommandEnum
	subscribe                  ServerCommandEnum
	unsubscribe                ServerCommandEnum
	rotate_cipher_keys         ServerCommandEnum
	update_processing_interval ServerCommandEnum
	define_operational_modes   ServerCommandEnum
	confirm_notification       ServerCommandEnum
	confirm_buffer_block       ServerCommandEnum
	confirm_signal_index_cache ServerCommandEnum
	user_command00             ServerCommandEnum
	user_command01             ServerCommandEnum
	user_command02             ServerCommandEnum
	user_command03             ServerCommandEnum
	user_command04             ServerCommandEnum
	user_command05             ServerCommandEnum
	user_command06             ServerCommandEnum
	user_command07             ServerCommandEnum
	user_command08             ServerCommandEnum
	user_command09             ServerCommandEnum
	user_command10             ServerCommandEnum
	user_command11             ServerCommandEnum
	user_command12             ServerCommandEnum
	user_command13             ServerCommandEnum
	user_command14             ServerCommandEnum
	user_command15             ServerCommandEnum
}

struct Go2VInlineStruct_3 {
mut:
	succeeded                 ServerResponseEnum
	failed                    ServerResponseEnum
	data_packet               ServerResponseEnum
	update_signal_index_cache ServerResponseEnum
	update_base_times         ServerResponseEnum
	update_cipher_keys        ServerResponseEnum
	data_start_time           ServerResponseEnum
	processing_complete       ServerResponseEnum
	buffer_block              ServerResponseEnum
	notification              ServerResponseEnum
	configuration_changed     ServerResponseEnum
	user_response00           ServerResponseEnum
	user_response01           ServerResponseEnum
	user_response02           ServerResponseEnum
	user_response03           ServerResponseEnum
	user_response04           ServerResponseEnum
	user_response05           ServerResponseEnum
	user_response06           ServerResponseEnum
	user_response07           ServerResponseEnum
	user_response08           ServerResponseEnum
	user_response09           ServerResponseEnum
	user_response10           ServerResponseEnum
	user_response11           ServerResponseEnum
	user_response12           ServerResponseEnum
	user_response13           ServerResponseEnum
	user_response14           ServerResponseEnum
	user_response15           ServerResponseEnum
	no_op                     ServerResponseEnum
}

struct Go2VInlineStruct_4 {
mut:
	version_mask                OperationalModesEnum
	compression_mode_mask       OperationalModesEnum
	encoding_mask               OperationalModesEnum
	receive_external_metadata   OperationalModesEnum
	receive_internal_metadata   OperationalModesEnum
	compress_payload_data       OperationalModesEnum
	compress_signal_index_cache OperationalModesEnum
	compress_metadata           OperationalModesEnum
	no_flags                    OperationalModesEnum
}

struct Go2VInlineStruct_5 {
mut:
	utf16_le OperationalEncodingEnum
	utf16_be OperationalEncodingEnum
	utf8     OperationalEncodingEnum
}

struct Go2VInlineStruct_6 {
mut:
	gzip     CompressionModesEnum
	tssc     CompressionModesEnum
	no_flags CompressionModesEnum
}

struct Go2VInlineStruct_7 {
mut:
	off SecurityModeEnum
	tls SecurityModeEnum
}

struct Go2VInlineStruct_8 {
mut:
	success  ConnectStatusEnum
	failed   ConnectStatusEnum
	canceled ConnectStatusEnum
}

// String gets the StateFlags enumeration bit values as a str
pub fn (mut sfe StateFlagsEnum) string() string {
	if sfe == transport.state_flags.normal {
		return 'Normal'
	}
	mut image := strings.Builder{}
	mut add_flag := fn (flag StateFlagsEnum, name string) {
		if flag & sfe > 0 {
			if image.len() > 0 {
				image.write_rune(`,`)
			}
			image.write_string(name)
		}
	}

	add_flag(transport.state_flags.bad_data, 'BadData')
	add_flag(transport.state_flags.suspect_data, 'SuspectData')
	add_flag(transport.state_flags.over_range_error, 'OverRangeError')
	add_flag(transport.state_flags.under_range_error, 'UnderRangeError')
	add_flag(transport.state_flags.alarm_high, 'AlarmHigh')
	add_flag(transport.state_flags.alarm_low, 'AlarmLow')
	add_flag(transport.state_flags.warning_high, 'WarningHigh')
	add_flag(transport.state_flags.warning_low, 'WarningLow')
	add_flag(transport.state_flags.flatline_alarm, 'FlatlineAlarm')
	add_flag(transport.state_flags.comparison_alarm, 'ComparisonAlarm')
	add_flag(transport.state_flags.rocalarm, 'ROCAlarm')
	add_flag(transport.state_flags.received_as_bad, 'ReceivedAsBad')
	add_flag(transport.state_flags.calculated_value, 'CalculatedValue')
	add_flag(transport.state_flags.calculation_error, 'CalculationError')
	add_flag(transport.state_flags.calculation_warning, 'CalculationWarning')
	add_flag(transport.state_flags.reserved_quality_flag, 'ReservedQualityFlag')
	add_flag(transport.state_flags.bad_time, 'BadTime')
	add_flag(transport.state_flags.suspect_time, 'SuspectTime')
	add_flag(transport.state_flags.late_time_alarm, 'LateTimeAlarm')
	add_flag(transport.state_flags.future_time_alarm, 'FutureTimeAlarm')
	add_flag(transport.state_flags.up_sampled, 'UpSampled')
	add_flag(transport.state_flags.down_sampled, 'DownSampled')
	add_flag(transport.state_flags.discarded_value, 'DiscardedValue')
	add_flag(transport.state_flags.reserved_time_flag, 'ReservedTimeFlag')
	add_flag(transport.state_flags.user_defined_flag1, 'UserDefinedFlag1')
	add_flag(transport.state_flags.user_defined_flag2, 'UserDefinedFlag2')
	add_flag(transport.state_flags.user_defined_flag3, 'UserDefinedFlag3')
	add_flag(transport.state_flags.user_defined_flag4, 'UserDefinedFlag4')
	add_flag(transport.state_flags.user_defined_flag5, 'UserDefinedFlag5')
	add_flag(transport.state_flags.system_error, 'SystemError')
	add_flag(transport.state_flags.system_warning, 'SystemWarning')
	add_flag(transport.state_flags.measurement_error, 'MeasurementError')
	return image.string()
}

// String gets the ServerCommand enumeration value as a str
pub fn (mut sce ServerCommandEnum) string_1() string {
	match sce {
		transport.server_command.connect {
			return 'Connect'
		}
		transport.server_command.metadata_refresh {
			return 'MetadataRefresh'
		}
		transport.server_command.subscribe {
			return 'Subscribe'
		}
		transport.server_command.unsubscribe {
			return 'Unsubscribe'
		}
		transport.server_command.rotate_cipher_keys {
			return 'RotateCipherKeys'
		}
		transport.server_command.update_processing_interval {
			return 'UpdateProcessingInterval'
		}
		transport.server_command.define_operational_modes {
			return 'DefineOperationalModes'
		}
		transport.server_command.confirm_notification {
			return 'ConfirmNotification'
		}
		transport.server_command.confirm_buffer_block {
			return 'ConfirmBufferBlock'
		}
		transport.server_command.confirm_signal_index_cache {
			return 'ConfirmSignalIndexCache'
		}
		transport.server_command.user_command00 {
			return 'UserCommand00'
		}
		transport.server_command.user_command01 {
			return 'UserCommand01'
		}
		transport.server_command.user_command02 {
			return 'UserCommand02'
		}
		transport.server_command.user_command03 {
			return 'UserCommand03'
		}
		transport.server_command.user_command04 {
			return 'UserCommand04'
		}
		transport.server_command.user_command05 {
			return 'UserCommand05'
		}
		transport.server_command.user_command06 {
			return 'UserCommand06'
		}
		transport.server_command.user_command07 {
			return 'UserCommand07'
		}
		transport.server_command.user_command08 {
			return 'UserCommand08'
		}
		transport.server_command.user_command09 {
			return 'UserCommand09'
		}
		transport.server_command.user_command10 {
			return 'UserCommand10'
		}
		transport.server_command.user_command11 {
			return 'UserCommand11'
		}
		transport.server_command.user_command12 {
			return 'UserCommand12'
		}
		transport.server_command.user_command13 {
			return 'UserCommand13'
		}
		transport.server_command.user_command14 {
			return 'UserCommand14'
		}
		transport.server_command.user_command15 {
			return 'UserCommand15'
		}
		else {
			return '0x' + strconv.format_int(i64(sce), 16)
		}
	}
}

// String gets the ServerResponse enumeration value as a str
pub fn (mut sre ServerResponseEnum) string_2() string {
	match sre {
		transport.server_response.succeeded {
			return 'Succeeded'
		}
		transport.server_response.failed {
			return 'Failed'
		}
		transport.server_response.data_packet {
			return 'DataPacket'
		}
		transport.server_response.update_signal_index_cache {
			return 'UpdateSignalIndexCache'
		}
		transport.server_response.update_base_times {
			return 'UpdateBaseTimes'
		}
		transport.server_response.update_cipher_keys {
			return 'UpdateCipherKeys'
		}
		transport.server_response.data_start_time {
			return 'DataStartTime'
		}
		transport.server_response.processing_complete {
			return 'ProcessingComplete'
		}
		transport.server_response.buffer_block {
			return 'BufferBlock'
		}
		transport.server_response.notification {
			return 'Notification'
		}
		transport.server_response.configuration_changed {
			return 'ConfigurationChanged'
		}
		transport.server_response.user_response00 {
			return 'UserResponse00'
		}
		transport.server_response.user_response01 {
			return 'UserResponse01'
		}
		transport.server_response.user_response02 {
			return 'UserResponse02'
		}
		transport.server_response.user_response03 {
			return 'UserResponse03'
		}
		transport.server_response.user_response04 {
			return 'UserResponse04'
		}
		transport.server_response.user_response05 {
			return 'UserResponse05'
		}
		transport.server_response.user_response06 {
			return 'UserResponse06'
		}
		transport.server_response.user_response07 {
			return 'UserResponse07'
		}
		transport.server_response.user_response08 {
			return 'UserResponse08'
		}
		transport.server_response.user_response09 {
			return 'UserResponse09'
		}
		transport.server_response.user_response10 {
			return 'UserResponse10'
		}
		transport.server_response.user_response11 {
			return 'UserResponse11'
		}
		transport.server_response.user_response12 {
			return 'UserResponse12'
		}
		transport.server_response.user_response13 {
			return 'UserResponse13'
		}
		transport.server_response.user_response14 {
			return 'UserResponse14'
		}
		transport.server_response.user_response15 {
			return 'UserResponse15'
		}
		transport.server_response.no_op {
			return 'NoOP'
		}
		else {
			return '0x' + strconv.format_int(i64(sre), 16)
		}
	}
}
