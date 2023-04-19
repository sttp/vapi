module sttp
import encoding.binary
import math
import net
import os
import strconv
import strings
import sync
import time
import goapi.
struct Subscriber {
mut:
config &Config 
ds &transport.DataSubscriber 
status_message_logger fn ( string)  
error_message_logger fn ( string)  
metadata_receiver fn ( &data.DataSet)  
data_start_time_receiver fn ( time.Time)  
configuration_changed_receiver fn ()  
historical_read_complete_receiver fn ()  
connection_established_receiver fn ()  
console_lock sync.Mutex 
assigning_handler_mutex sync.RWMutex 
}
// NewSubscriber creates a new Subscri
pub fn new_subscriber() (&Subscriber, ) {mut sb:=Subscriber{
config:new_config()  ,
ds:transport.new_data_subscriber()  }  
sb.status_message_logger=sb.default_status_message_logger  
sb.error_message_logger=sb.default_error_message_logger  
sb.connection_established_receiver=sb.default_connection_established_receiver  
sb.ds.connection_terminated_callback=sb.default_connection_terminated_receiver  
return & sb  
}

// Close cleanly shuts down a Subscriber that is no longer being used, e
pub fn (mut sb Subscriber) close() {if sb.ds  !=  unsafe { nil }  {
sb.ds.dispose()
}
}

// dataSubscriber gets a reference to the internal DataSubscriber insta
fn (mut sb Subscriber) data_subscriber() (&transport.DataSubscriber, ) {if sb.ds  ==  unsafe { nil }  {
panic("Internal DataSubscriber instance has not been initialized. Make sure to use NewSubscriber." ,)
}
return sb.ds 
}

// IsConnected determines if Subscriber is currently connected to a data publis
pub fn (mut sb Subscriber) is_connected() (bool, ) {return sb.data_subscriber.is_connected() 
}

// IsValidated determines if Subscriber connection has been validated as an STTP connect
pub fn (mut sb Subscriber) is_validated() (bool, ) {return sb.data_subscriber.is_validated() 
}

// IsListening determines if Subscriber is currently listening for connections 
pub fn (mut sb Subscriber) is_listening() (bool, ) {return sb.data_subscriber.is_listening() 
}

// IsSubscribed determines if Subscriber is currently subscribed to a data str
pub fn (mut sb Subscriber) is_subscribed() (bool, ) {return sb.data_subscriber.is_subscribed() 
}

// ConnectionID returns the IP address and DNS host name, if resolvable, of current STTP connect
pub fn (mut sb Subscriber) connection_id() (string, ) {return sb.data_subscriber.connection_id() 
}

// ActiveSignalIndexCache gets the active signal index ca
pub fn (mut sb Subscriber) active_signal_index_cache() (&transport.SignalIndexCache, ) {return sb.data_subscriber.active_signal_index_cache() 
}

// SubscriberID gets the subscriber ID as assigned by the data publisher upon receipt of the SignalIndexCa
pub fn (mut sb Subscriber) subscriber_id() (guid.Guid, ) {return sb.data_subscriber.subscriber_id() 
}

// TotalCommandChannelBytesReceived gets the total number of bytes received via the command channel since last connect
pub fn (mut sb Subscriber) total_command_channel_bytes_received() (u64, ) {return sb.data_subscriber.total_command_channel_bytes_received() 
}

// TotalDataChannelBytesReceived gets the total number of bytes received via the data channel since last connect
pub fn (mut sb Subscriber) total_data_channel_bytes_received() (u64, ) {return sb.data_subscriber.total_data_channel_bytes_received() 
}

// TotalMeasurementsReceived gets the total number of measurements received since last subscript
pub fn (mut sb Subscriber) total_measurements_received() (u64, ) {return sb.data_subscriber.total_measurements_received() 
}

// LookupMetadata gets the MeasurementMetadata for the specified signalID from the l
pub fn (mut sb Subscriber) lookup_metadata(signalID guid.Guid) (&transport.MeasurementMetadata, ) {return sb.data_subscriber.lookup_metadata(signalID ,) 
}

// Metadata gets the measurement-level metadata associated with a measurement from the l
pub fn (mut sb Subscriber) metadata(measurement &transport.Measurement) (&transport.MeasurementMetadata, ) {return sb.data_subscriber.metadata(measurement ,) 
}

// AdjustedValue gets the Value of a Measurement with any linear adjustments applied from
pub fn (mut sb Subscriber) adjusted_value(measurement_1 &transport.Measurement) (f64, ) {return sb.data_subscriber.adjusted_value(measurement_1 ,) 
}

// Dial starts the client-based connection cycle to an STTP publisher. Config parameter cont
pub fn (mut sb Subscriber) dial(address string, config &Config) (error, ) {if sb.is_connected() {
return errors.new("subscriber is already connected; cannot dial at this time" ,) 
}
if sb.is_listening() {
return errors.new("subscriber is listening for connections; cannot dial at this time" ,) 
}
mut hostname,portname,err:=net.split_host_port(address ,)  
if err  !=  unsafe { nil }  {
return err 
}
mut port,err_1:=strconv.atoi(portname ,)  
if err_1  !=  unsafe { nil }  {
return error(strconv.v_sprintf("invalid port number \"%s\": %s" ,portname ,err_1.error() ,) ,) 
}
if port  <  1   ||  port  >  math.max_uint16   {
return error(strconv.v_sprintf("port number \"%s\" is out of range: must be 1 to %d" ,portname ,math.max_uint16 ,) ,) 
}
if config  !=  unsafe { nil }  {
sb.config=config  
}
return sb.connect(hostname ,u16(port ,) ,) 
}

fn (mut sb Subscriber) connect(hostname string, port u16) (error, ) {if sb.config  ==  unsafe { nil }  {
panic("Internal Config instance has not been initialized. Make sure to use NewSubscriber." ,)
}
mut ds:=sb.data_subscriber()  
mut con:=ds.connector()  
con.hostname=hostname  
con.port=port  
con.max_retries=sb.config.max_retries  
con.retry_interval=sb.config.retry_interval  
con.max_retry_interval=sb.config.max_retry_interval  
con.auto_reconnect=sb.config.auto_reconnect  
ds.compress_payload_data=sb.config.compress_payload_data  
ds.compress_metadata=sb.config.compress_metadata  
ds.compress_signal_index_cache=sb.config.compress_signal_index_cache  
ds.version=sb.config.version  
ds.swap_guid_endianness=! sb.config.rfc_guid_encoding   
con.begin_callback_assignment()
ds.begin_callback_assignment()
sb.begin_callback_sync()
con.error_message_callback=sb.error_message_logger  
ds.status_message_callback=sb.status_message_logger  
ds.error_message_callback=sb.error_message_logger  
con.reconnect_callback=sb.handle_reconnect  
ds.metadata_received_callback=sb.handle_metadata_received  
ds.data_start_time_callback=sb.handle_data_start_time  
ds.configuration_changed_callback=sb.handle_configuration_changed  
ds.processing_complete_callback=sb.handle_processing_complete  
sb.end_callback_sync()
con.end_callback_assignment()
ds.end_callback_assignment()
mut err:=error{} 
 match con.connect(ds ,) {transport.connect_status.success {
sb.handle_connect()
}
transport.connect_status.failed {
err=errors.new("all connection attempts failed" ,)  
}
transport.connect_status.canceled {
err=errors.new("connection canceled" ,)  
}
else{
}
}
return err 
}

// Listen establishes a listening socket for an incoming STTP publisher connection, also k
pub fn (mut sb Subscriber) listen(address_1 string, config_1 &Config) (error, ) {if sb.is_listening() {
return errors.new("subscriber is already listening for connections; cannot listen at this time" ,) 
}
if sb.is_connected() {
return errors.new("subscriber is already connected; cannot listen at this time" ,) 
}
mut network_interface,portname,err:=net.split_host_port(address_1 ,)  
if err  !=  unsafe { nil }  {
return err 
}
mut port_1,err_1:=strconv.atoi(portname ,)  
if err_1  !=  unsafe { nil }  {
return error(strconv.v_sprintf("invalid port number \"%s\": %s" ,portname ,err_1.error() ,) ,) 
}
if port_1  <  1   ||  port_1  >  math.max_uint16   {
return error(strconv.v_sprintf("port number \"%s\" is out of range: must be 1 to %d" ,portname ,math.max_uint16 ,) ,) 
}
if config_1  !=  unsafe { nil }  {
sb.config=config_1  
}
return sb.listen(u16(port_1 ,) ,network_interface ,) 
}

fn (mut sb Subscriber) listen_1(port_1 u16, networkInterface string) (error, ) {if sb.config  ==  unsafe { nil }  {
panic("Internal Config instance has not been initialized. Make sure to use NewSubscriber." ,)
}
mut ds:=sb.data_subscriber()  
ds.compress_payload_data=sb.config.compress_payload_data  
ds.compress_metadata=sb.config.compress_metadata  
ds.compress_signal_index_cache=sb.config.compress_signal_index_cache  
ds.version=sb.config.version  
ds.swap_guid_endianness=! sb.config.rfc_guid_encoding   
ds.begin_callback_assignment()
sb.begin_callback_sync()
ds.status_message_callback=sb.status_message_logger  
ds.error_message_callback=sb.error_message_logger  
ds.connection_established_callback=sb.handle_connect  
ds.metadata_received_callback=sb.handle_metadata_received  
ds.data_start_time_callback=sb.handle_data_start_time  
ds.configuration_changed_callback=sb.handle_configuration_changed  
ds.processing_complete_callback=sb.handle_processing_complete  
sb.end_callback_sync()
ds.end_callback_assignment()
return ds.listen(port_1 ,networkInterface ,) 
}

// Disconnect disconnects from an STTP publis
pub fn (mut sb Subscriber) disconnect() {sb.data_subscriber.disconnect()
}

// RequestMetadata sends a request to the data publisher indicating that the Subscriber w
pub fn (mut sb Subscriber) request_metadata() {mut ds:=sb.data_subscriber()  
if sb.config.metadata_filters .len  ==  0  {
ds.send_server_command(transport.server_command.metadata_refresh ,)
return 
}
mut filters:=ds.encode_string(sb.config.metadata_filters ,)  
mut buffer:=[]u8{len: 4  +  filters .len  }  
binary.big_endian.put_uint32(buffer ,u32(filters .len ,) ,)
copy(buffer[4 .. ] ,filters ,)
ds.send_server_command_with_payload(transport.server_command.metadata_refresh ,buffer ,)
}

// Subscribe sets up a request indicating that the Subscriber would like to start recei
pub fn (mut sb Subscriber) subscribe(filterExpression string, settings &Settings) {mut ds:=sb.data_subscriber()  
mut sub:=ds.subscription()  
if settings  ==  unsafe { nil }  {
settings=& settings_defaults   
}
sub.filter_expression=filterExpression  
sub.throttled=settings.throttled  
sub.publish_interval=settings.publish_interval  
if settings.udp_port  >  0  {
sub.udp_data_channel=true  
sub.data_channel_local_port=settings.udp_port  
}else {
sub.udp_data_channel=false  
sub.data_channel_local_port=0  
}
sub.include_time=settings.include_time  
sub.enable_time_reasonability_check=settings.enable_time_reasonability_check  
sub.lag_time=settings.lag_time  
sub.lead_time=settings.lead_time  
sub.use_local_clock_as_real_time=settings.use_local_clock_as_real_time  
sub.use_millisecond_resolution=settings.use_millisecond_resolution  
sub.request_na_nvalue_filter=settings.request_na_nvalue_filter  
sub.start_time=settings.start_time  
sub.stop_time=settings.stop_time  
sub.constraint_parameters=settings.constraint_parameters  
sub.processing_interval=settings.processing_interval  
sub.extra_connection_string_parameters=settings.extra_connection_string_parameters  
if ds.is_connected() {
ds.subscribe()
}
}

// Unsubscribe sends a request to the data publisher indicating that the Subscriber w
pub fn (mut sb Subscriber) unsubscribe() {sb.data_subscriber.unsubscribe()
}

// ReadMeasurements sets up a new MeasurementReader to start reading measureme
pub fn (mut sb Subscriber) read_measurements() (&MeasurementReader, ) {return new_measurement_reader(sb ,) 
}

// beginCallbackAssignment informs Subscriber that a callback change has been initia
fn (mut sb Subscriber) begin_callback_assignment() {sb.assigning_handler_mutex.@lock()
}

// beginCallbackSync begins a callback synchronization operat
fn (mut sb Subscriber) begin_callback_sync() {sb.assigning_handler_mutex.@rlock()
}

// endCallbackSync ends a callback synchronization operat
fn (mut sb Subscriber) end_callback_sync() {sb.assigning_handler_mutex.runlock()
}

// endCallbackAssignment informs Subscriber that a callback change has been comple
fn (mut sb Subscriber) end_callback_assignment() {sb.assigning_handler_mutex.unlock()
}

// StatusMessage executes the defined status message logger callb
pub fn (mut sb Subscriber) status_message(message_2 string) {sb.begin_callback_sync()
if sb.status_message_logger  !=  unsafe { nil }  {
sb.status_message_logger(message_2 ,)
}
sb.end_callback_sync()
}

// ErrorMessage executes the defined error message logger callb
pub fn (mut sb Subscriber) error_message(message_3 string) {sb.begin_callback_sync()
if sb.error_message_logger  !=  unsafe { nil }  {
sb.error_message_logger(message_3 ,)
}
sb.end_callback_sync()
}

fn (mut sb Subscriber) handle_connect() {sb.begin_callback_sync()
if sb.connection_established_receiver  !=  unsafe { nil }  {
sb.connection_established_receiver()
}
sb.end_callback_sync()
if sb.config.auto_request_metadata {
sb.request_metadata()
}else if sb.config.auto_subscribe {
sb.data_subscriber.subscribe()
}
}

fn (mut sb Subscriber) handle_reconnect(ds &transport.DataSubscriber) {if ds.is_connected() {
sb.handle_connect()
}else {
ds.disconnect()
sb.status_message("Connection retry attempts exceeded." ,)
}
}

fn (mut sb Subscriber) handle_metadata_received(metadata_1 []u8) {mut parse_started:=time.now()  
mut data_set:=data.new_data_set()  
mut err:=data_set.parse_xml(metadata_1 ,)  
if err  ==  unsafe { nil }  {
sb.load_measurement_metadata(data_set ,)
}else {
sb.error_message("Failed to parse received XML metadata: "  +  err.error()  ,)
}
sb.show_metadata_summary(data_set ,parse_started ,)
sb.begin_callback_sync()
if sb.metadata_receiver  !=  unsafe { nil }  {
sb.metadata_receiver(data_set ,)
}
sb.end_callback_sync()
if sb.config.auto_request_metadata  &&  sb.config.auto_subscribe  {
sb.data_subscriber.subscribe()
}
}

fn (mut sb Subscriber) load_measurement_metadata(dataSet_1 &data.DataSet) {mut measurements:=dataSet_1.table("MeasurementDetail" ,)  
if measurements  !=  unsafe { nil }  {
mut signal_idindex:=measurements.column_index("SignalID" ,)  
if signal_idindex  >  - 1   {
mut id_index:=measurements.column_index("ID" ,)  
mut point_tag_index:=measurements.column_index("PointTag" ,)  
mut signal_ref_index:=measurements.column_index("SignalReference" ,)  
mut signal_type_index:=measurements.column_index("SignalAcronym" ,)  
mut description_index:=measurements.column_index("Description" ,)  
mut updated_on_index:=measurements.column_index("UpdatedOn" ,)  
mut ds_1:=sb.data_subscriber()  
for i:=0  ;i  <  measurements.row_count()  ;i++ {
mut measurement_2:=measurements.row(i ,)  
if measurement_2  ==  unsafe { nil }  {
continue 
}
mut signal_id,null,err:=measurement_2.guid_value(signal_idindex ,)  
if null  ||  err  !=  unsafe { nil }   {
continue 
}
mut metadata_1:=ds_1.lookup_metadata(signal_id ,)  
if id_index  >  - 1   {
mut id,_,_:=measurement_2.string_value(id_index ,)  
mut parts:=id .split(":" ,)  
if parts .len  ==  2  {
metadata_1.source=parts[0 ]  
metadata_1.id,_=strconv.parse_uint(parts[1 ] ,10 ,64 ,)  
}
}
if point_tag_index  >  - 1   {
metadata_1.tag,_,_=measurement_2.string_value(point_tag_index ,)  
}
if signal_ref_index  >  - 1   {
metadata_1.signal_reference,_,_=measurement_2.string_value(signal_ref_index ,)  
}
if signal_type_index  >  - 1   {
metadata_1.signal_type,_,_=measurement_2.string_value(signal_type_index ,)  
}
if description_index  >  - 1   {
metadata_1.description,_,_=measurement_2.string_value(description_index ,)  
}
if updated_on_index  >  - 1   {
metadata_1.updated_on,_,_=measurement_2.date_time_value(updated_on_index ,)  
}
}
}else {
sb.error_message("Received metadata does not contain the required MeasurementDetail.SignalID field" ,)
}
}else {
sb.error_message("Received metadata does not contain the required MeasurementDetail table" ,)
}
}

fn (mut sb Subscriber) show_metadata_summary(dataSet_2 &data.DataSet, parseStarted time.Time) {mut get_row_count:=fn (tableName string) (int, ) {mut table:=dataSet_2.table(tableName ,)  
if table  ==  unsafe { nil }  {
return 0 
}
return table.row_count() 
}
  
mut table_details:=strings.Builder{} 
mut total_rows:=0  
table_details.write_string("    Discovered:\n" ,)
for _, table in  dataSet_2.tables()  {
mut table_name:=table.name()  
mut table_rows:=get_row_count(table_name ,)  
total_rows+=table_rows  
table_details.write_string(strconv.v_sprintf("        %s %s records\n" ,format.int(table_rows ,) ,table_name ,) ,)
}
mut message_4:=strings.Builder{} 
message_4.write_string("Parsed " ,)
message_4.write_string(format.int(total_rows ,) ,)
message_4.write_string(" metadata records in " ,)
message_4.write_string(format.float(time.since.seconds() ,3 ,) ,)
message_4.write_string(" seconds.\n" ,)
message_4.write_string(table_details.string() ,)
mut schema_version:=dataSet_2.table("SchemaVersion" ,)  
if schema_version  !=  unsafe { nil }  {
message_4.write_string("Metadata schema version: "  +  schema_version.row_value_as_string_by_name(0 ,"VersionNumber" ,)  ,)
}else {
message_4.write_string("No SchemaVersion table found in metadata" ,)
}
sb.status_message(message_4.string() ,)
}

fn (mut sb Subscriber) handle_data_start_time(startTime_1 ticks.Ticks) {sb.begin_callback_sync()
if sb.data_start_time_receiver  !=  unsafe { nil }  {
sb.data_start_time_receiver(ticks.to_time(startTime_1 ,) ,)
}
sb.end_callback_sync()
}

fn (mut sb Subscriber) handle_configuration_changed() {sb.begin_callback_sync()
if sb.configuration_changed_receiver  !=  unsafe { nil }  {
sb.configuration_changed_receiver()
}
sb.end_callback_sync()
if sb.config.auto_request_metadata {
sb.request_metadata()
}
}

fn (mut sb Subscriber) handle_processing_complete(message_4 string) {sb.status_message(message_4 ,)
sb.begin_callback_sync()
if sb.historical_read_complete_receiver  !=  unsafe { nil }  {
sb.historical_read_complete_receiver()
}
sb.end_callback_sync()
}

// DefaultStatusMessageLogger implements the default handler for the statusMessage callb
pub fn (mut sb Subscriber) default_status_message_logger(message_5 string) {sb.console_lock.@lock()
defer {sb.console_lock.unlock()
}
println(message_5 ,)
}

// DefaultErrorMessageLogger implements the default handler for the errorMessage callb
pub fn (mut sb Subscriber) default_error_message_logger(message_6 string) {sb.console_lock.@lock()
defer {sb.console_lock.unlock()
}
println(message_6 ,)
}

// DefaultConnectionEstablishedReceiver implements the default handler for the ConnectionEstablished callb
pub fn (mut sb Subscriber) default_connection_established_receiver() {mut dir:='' 
if sb.is_listening() {
dir="from"  
}else {
dir="to"  
}
sb.status_message("Connection "  +  dir   +  " "   +  sb.connection_id()   +  " established."  ,)
}

// DefaultConnectionTerminatedReceiver implements the default handler for the ConnectionTerminated callb
pub fn (mut sb Subscriber) default_connection_terminated_receiver() {sb.error_message("Connection for "  +  sb.connection_id()   +  " terminated."  ,)
}

// SetStatusMessageLogger defines the callback that handles informational message logg
pub fn (mut sb Subscriber) set_status_message_logger(callback fn ( string) ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.status_message_logger=callback  
}

// SetErrorMessageLogger defines the callback that handles error message logg
pub fn (mut sb Subscriber) set_error_message_logger(callback_1 fn ( string) ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.error_message_logger=callback_1  
}

// SetMetadataReceiver defines the callback that handles reception of the metadata respo
pub fn (mut sb Subscriber) set_metadata_receiver(callback_2 fn ( &data.DataSet) ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.metadata_receiver=callback_2  
}

// SetSubscriptionUpdatedReceiver defines the callback that handles notifications that a
pub fn (mut sb Subscriber) set_subscription_updated_receiver(callback_3 fn ( &transport.SignalIndexCache) ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.data_subscriber.subscription_updated_callback=callback_3  
}

// SetDataStartTimeReceiver defines the callback that handles notification of first received measurem
pub fn (mut sb Subscriber) set_data_start_time_receiver(callback_4 fn ( time.Time) ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.data_start_time_receiver=callback_4  
}

// SetConfigurationChangedReceiver defines the callback that handles notifications that the data publi
pub fn (mut sb Subscriber) set_configuration_changed_receiver(callback_5 fn () ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.configuration_changed_receiver=callback_5  
}

// SetNewMeasurementsReceiver defines the callback that handles reception of new measureme
pub fn (mut sb Subscriber) set_new_measurements_receiver(callback_6 fn ( []transport.Measurement) ) {mut ds_1:=sb.data_subscriber()  
ds_1.begin_callback_assignment()
defer {ds_1.end_callback_assignment()
}
ds_1.new_measurements_callback=callback_6  
}

// SetNewBufferBlocksReceiver defines the callback that handles reception of new buffer blo
pub fn (mut sb Subscriber) set_new_buffer_blocks_receiver(callback_7 fn ( []transport.BufferBlock) ) {mut ds_1:=sb.data_subscriber()  
ds_1.begin_callback_assignment()
defer {ds_1.end_callback_assignment()
}
ds_1.new_buffer_blocks_callback=callback_7  
}

// SetNotificationReceiver defines the callback that handles reception of a notificat
pub fn (mut sb Subscriber) set_notification_receiver(callback_8 fn ( string) ) {mut ds_1:=sb.data_subscriber()  
ds_1.begin_callback_assignment()
defer {ds_1.end_callback_assignment()
}
ds_1.notification_received_callback=callback_8  
}

// SetHistoricalReadCompleteReceiver defines the callback that handles notification that temporal proces
pub fn (mut sb Subscriber) set_historical_read_complete_receiver(callback_9 fn () ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.historical_read_complete_receiver=callback_9  
}

// SetConnectionEstablishedReceiver defines the callback that handles notification that a connection has been establis
pub fn (mut sb Subscriber) set_connection_established_receiver(callback_10 fn () ) {sb.begin_callback_assignment()
defer {sb.end_callback_assignment()
}
sb.connection_established_receiver=callback_10  
}

// SetConnectionTerminatedReceiver defines the callback that handles notification that a connection has been termina
pub fn (mut sb Subscriber) set_connection_terminated_receiver(callback_11 fn () ) {mut ds_1:=sb.data_subscriber()  
ds_1.begin_callback_assignment()
defer {ds_1.end_callback_assignment()
}
ds_1.connection_terminated_callback=callback_11  
}
