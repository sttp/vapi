module main
import strconv
import strings
import time
import github.com.sttp.goapi.sttp
const target_version=u8(2 )
fn main() {mut address:=parse_cmd_line_args()  
mut subscriber:=sttp.new_subscriber()  
defer {subscriber.close()
}
subscriber.set_connection_established_receiver(fn () {subscriber.default_connection_established_receiver()
go mut reader:=subscriber.read_measurements()    go mut last_message:=time.Time{}   go for subscriber.is_connected() {
mut measurement,_:=reader.next_measurement(unsafe { nil } ,)  
if time.since.seconds()  <  5.0  {
continue 
}else if last_message.is_zero() {
subscriber.status_message("Receiving measurements..." ,)
last_message=time.now()  
continue 
}
mut message:=strings.Builder{} 
message.write_string(strconv.format_uint(subscriber.total_measurements_received() ,10 ,) ,)
message.write_string(" measurements received so far. Current measurement:\n    " ,)
message.write_string(measurement.string() ,)
subscriber.status_message(message.string() ,)
last_message=time.now()  
}  
}
 ,)
mut get_filter_expression:=fn (count int) (string, ) {mut message:=strings.Builder{} 
message.write_string("FILTER TOP " ,)
message.write_string(strconv.itoa(count ,) ,)
message.write_string(" ActiveMeasurements WHERE SignalType <> 'STAT'" ,)
return message.string() 
}
  
mut count_1:=1  
subscriber.subscribe(get_filter_expression(count_1 ,) ,unsafe { nil } ,)
mut config:=sttp.new_config()  
config.version=target_version  
subscriber.dial(address ,config ,)
mut key:=read_key()  
for key  !=  ` `  {
count_1++
subscriber.subscribe(get_filter_expression(count_1 ,) ,unsafe { nil } ,)
key=read_key()  
}
}
