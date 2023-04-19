module main

import strconv
import strings
import time
import github.com.sttp.goapi.sttp
import github.com.sttp.goapi.sttp.format
import github.com.sttp.goapi.sttp.transport

struct AdvancedSubscriber {
	sttp.Subscriber
mut:
	config       &sttp.Config
	settings     &sttp.Settings
	last_message time.Time
}

// NewAdvancedSubscriber creates a new AdvancedSubscri
pub fn new_advanced_subscriber() &AdvancedSubscriber {
	mut subscriber := &AdvancedSubscriber{
		subscriber: *sttp.NewSubscriber
		config: sttp.new_config()
		settings: sttp.new_settings()
	}
	subscriber.set_subscription_updated_receiver(subscriber.subscription_updated)
	subscriber.set_new_measurements_receiver(subscriber.received_new_measurements)
	subscriber.set_connection_terminated_receiver(subscriber.connection_terminated)
	return subscriber
}

fn main() {
	mut address := parse_cmd_line_args()
	mut subscriber := new_advanced_subscriber()
	subscriber.config.compress_payload_data = false
	subscriber.settings.udp_port = 9600
	subscriber.settings.use_millisecond_resolution = true
	subscriber.subscribe('FILTER TOP 20 ActiveMeasurements WHERE True', subscriber.settings)
	subscriber.dial(address, subscriber.config)
	defer {
		subscriber.close()
	}
	read_key()
}

fn (mut sub AdvancedSubscriber) subscription_updated(signalIndexCache &transport.SignalIndexCache) {
	sub.status_message(strconv.v_sprintf('Received signal index cache with %d mappings',
		signalIndexCache.count()))
}

fn (mut sub AdvancedSubscriber) received_new_measurements(measurements []transport.Measurement) {
	if time.since.seconds() < 5.0 {
		return
	}
	defer {
		sub.last_message = time.now()
	}
	if sub.last_message.is_zero() {
		sub.status_message('Receiving measurements...')
		return
	}
	mut message := strings.Builder{}
	message.write_string(format.uint64(sub.total_measurements_received()))
	message.write_string(' measurements received so far...\n')
	message.write_string('Timestamp: ')
	message.write_string(measurements[0].timestamp.string())
	message.write_rune(`\n`)
	message.write_string('\tID\tSignal ID\t\t\t\tValue\n')
	for i := 0; i < measurements.len; i++ {
		mut measurement := measurements[i]
		mut metadata := sub.metadata(&measurement)
		message.write_rune(`\t`)
		message.write_string(strconv.format_uint(metadata.id, 10))
		message.write_rune(`\t`)
		message.write_string(measurement.signal_id.string())
		message.write_rune(`\t`)
		message.write_string(format.float(measurement.value, 6))
		message.write_rune(`\n`)
	}
	sub.status_message(message.string())
}

fn (mut sub AdvancedSubscriber) connection_terminated() {
	sub.default_connection_established_receiver()
	sub.last_message = time.Time{}
}
