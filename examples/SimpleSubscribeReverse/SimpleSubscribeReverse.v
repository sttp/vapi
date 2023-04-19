module main
import context
import strconv
import strings
import time
import github.com.sttp.goapi.sttp
fn main() {mut address:=parse_cmd_line_args()  
mut subscriber:=sttp.new_subscriber()  
defer {subscriber.close()
}
subscriber.set_connection_established_receiver(fn () {subscriber.default_connection_established_receiver()
go mut reader:=subscriber.read_measurements()    go mut last_message:=time.Time{}   go for subscriber.is_connected() {
mut measurement,_:=reader.next_measurement(context.background() ,)  
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
subscriber.subscribe("FILTER TOP 20 ActiveMeasurements WHERE True" ,unsafe { nil } ,)
mut err:=subscriber.listen(address ,unsafe { nil } ,)  
if err  ==  unsafe { nil }  {
subscriber.status_message("Listening for STTP server connection on "  +  address  ,)
}else {
subscriber.error_message("Failed to listen for STTP server connection on "  +  address   +  ": "   +  err.error()  ,)
}
read_key()
}
