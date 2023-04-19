module tssc
import math
import strconv
import strings
struct Decoder {
mut:
data []u8 
position int 
last_position int 
prev_timestamp1 i64 
prev_timestamp2 i64 
prev_time_delta1 i64 
prev_time_delta2 i64 
prev_time_delta3 i64 
prev_time_delta4 i64 
last_point &pointMetadata 
points map[i32]&pointMetadata 
bit_stream_count i32 
bit_stream_cache i32 
sequence_number u16 
}
// NewDecoder creates a new TSSC deco
pub fn new_decoder() (&Decoder, ) {mut td:=& Decoder{
prev_time_delta1:math.max_int64  ,
prev_time_delta2:math.max_int64  ,
prev_time_delta3:math.max_int64  ,
prev_time_delta4:math.max_int64  ,
points:map[i32]*pointMetadata{}  }   
td.last_point=td.new_point_metadata()  
return td 
}

fn (mut td Decoder) new_point_metadata() (&pointMetadata, ) {return new_point_metadata(unsafe { nil } ,td.read_bit ,td.read_bits5 ,) 
}

fn (mut td Decoder) bit_stream_is_empty() (bool, ) {return td.bit_stream_count  ==  0  
}

fn (mut td Decoder) clear_bit_stream() {td.bit_stream_count=0  
td.bit_stream_cache=0  
}

// SetBuffer assigns the working buffer to use for decoding measureme
pub fn (mut td Decoder) set_buffer(data []u8) {td.clear_bit_stream()
td.data=data  
td.position=0  
td.last_position=data .len  
}

// TryGetMeasurement attempts to get the next decoded measurement from the working buf
pub fn (mut td Decoder) try_get_measurement(id &i32, timestamp &i64, stateFlags &u32, value &f32) (bool, error, ) {if td.position  ==  td.last_position   &&  td.bit_stream_is_empty()  {
td.clear_bit_stream()
*id=0  
*timestamp=0  
*stateFlags=0  
*value=0.0  
return false ,unsafe { nil } 
}
mut code,err:=td.last_point.read_code()  
if err  !=  unsafe { nil }  {
return false ,err 
}
if code  ==  i32(code_words.end_of_stream ,)  {
td.clear_bit_stream()
*id=0  
*timestamp=0  
*stateFlags=0  
*value=0.0  
return false ,unsafe { nil } 
}
if code  <=  i32(code_words.point_idxor32 ,)  {
mut err_1:=td.decode_point_id(u8(code ,) ,)  
if err_1  !=  unsafe { nil }  {
return false ,err_1 
}
code,err_1=td.last_point.read_code()  
if err_1  !=  unsafe { nil }  {
return false ,err_1 
}
if code  <  i32(code_words.time_delta1_forward ,)  {
mut message:=strings.Builder{} 
message.write_string("expecting code >= " ,)
message.write_string(strconv.itoa(int(code_words.time_delta1_forward ,) ,) ,)
message.write_string(" at position " ,)
message.write_string(strconv.itoa(td.position ,) ,)
message.write_string(" with last position " ,)
message.write_string(strconv.itoa(td.last_position ,) ,)
return false ,errors.new(message.string() ,) 
}
}
*id=td.last_point.prev_next_point_id1  
mut next_point:=&pointMetadata{} 
mut ok:=false 
next_point,ok=td.points[*id ] 
if ! ok   ||  next_point  ==  unsafe { nil }   {
next_point=td.new_point_metadata()  
td.points[*id ]=next_point  
next_point.prev_next_point_id1=*id  +  1   
}
if code  <=  i32(code_words.time_xor7_bit ,)  {
*timestamp=td.decode_timestamp(u8(code ,) ,)  
code,err=td.last_point.read_code()  
if err  !=  unsafe { nil }  {
return false ,err 
}
if code  <  i32(code_words.state_flags2 ,)  {
mut message:=strings.Builder{} 
message.write_string("expecting code >= " ,)
message.write_string(strconv.itoa(int(code_words.state_flags2 ,) ,) ,)
message.write_string(" at position " ,)
message.write_string(strconv.itoa(td.position ,) ,)
message.write_string(" with last position " ,)
message.write_string(strconv.itoa(td.last_position ,) ,)
return false ,errors.new(message.string() ,) 
}
}else {
*timestamp=td.prev_timestamp1  
}
if code  <=  i32(code_words.state_flags7_bit32 ,)  {
*stateFlags=td.decode_state_flags(u8(code ,) ,next_point ,)  
code,err=td.last_point.read_code()  
if err  !=  unsafe { nil }  {
return false ,err 
}
if code  <  i32(code_words.value1 ,)  {
mut message:=strings.Builder{} 
message.write_string("expecting code >= " ,)
message.write_string(strconv.itoa(int(code_words.value1 ,) ,) ,)
message.write_string(" at position " ,)
message.write_string(strconv.itoa(td.position ,) ,)
message.write_string(" with last position " ,)
message.write_string(strconv.itoa(td.last_position ,) ,)
return false ,errors.new(message.string() ,) 
}
}else {
*stateFlags=next_point.prev_state_flags1  
}
mut value_raw:=0 
if code  ==  i32(code_words.value1 ,)  {
value_raw=next_point.prev_value1  
}else if code  ==  i32(code_words.value2 ,)  {
value_raw=next_point.prev_value2  
next_point.prev_value2=next_point.prev_value1  
next_point.prev_value1=value_raw  
}else if code  ==  i32(code_words.value3 ,)  {
value_raw=next_point.prev_value3  
next_point.prev_value3=next_point.prev_value2  
next_point.prev_value2=next_point.prev_value1  
next_point.prev_value1=value_raw  
}else if code  ==  i32(code_words.value_zero ,)  {
value_raw=0  
next_point.prev_value3=next_point.prev_value2  
next_point.prev_value2=next_point.prev_value1  
next_point.prev_value1=value_raw  
}else {
 match u8(code ,) {code_words.value_xor4 {
value_raw=u32(td.read_bits4() ,)  ^  next_point.prev_value1   
}
code_words.value_xor8 {
value_raw=u32(td.data[td.position ] ,)  ^  next_point.prev_value1   
td.position++
}
code_words.value_xor12 {
value_raw=u32(td.read_bits4() ,)  ^  u32(td.data[td.position ] ,)  <<  4    ^  next_point.prev_value1   
td.position++
}
code_words.value_xor16 {
value_raw=u32(td.data[td.position ] ,)  ^  u32(td.data[td.position  +  1  ] ,)  <<  8    ^  next_point.prev_value1   
td.position+=2  
}
code_words.value_xor20 {
value_raw=u32(td.read_bits4() ,)  ^  u32(td.data[td.position ] ,)  <<  4    ^  u32(td.data[td.position  +  1  ] ,)  <<  12    ^  next_point.prev_value1   
td.position+=2  
}
code_words.value_xor24 {
value_raw=u32(td.data[td.position ] ,)  ^  u32(td.data[td.position  +  1  ] ,)  <<  8    ^  u32(td.data[td.position  +  2  ] ,)  <<  16    ^  next_point.prev_value1   
td.position+=3  
}
code_words.value_xor28 {
value_raw=u32(td.read_bits4() ,)  ^  u32(td.data[td.position ] ,)  <<  4    ^  u32(td.data[td.position  +  1  ] ,)  <<  12    ^  u32(td.data[td.position  +  2  ] ,)  <<  20    ^  next_point.prev_value1   
td.position+=3  
}
code_words.value_xor32 {
value_raw=u32(td.data[td.position ] ,)  ^  u32(td.data[td.position  +  1  ] ,)  <<  8    ^  u32(td.data[td.position  +  2  ] ,)  <<  16    ^  u32(td.data[td.position  +  3  ] ,)  <<  24    ^  next_point.prev_value1   
td.position+=4  
}
else{
mut message:=strings.Builder{} 
message.write_string("invalid code received " ,)
message.write_string(strconv.itoa(int(code ,) ,) ,)
message.write_string(" at position " ,)
message.write_string(strconv.itoa(td.position ,) ,)
message.write_string(" with last position " ,)
message.write_string(strconv.itoa(td.last_position ,) ,)
return false ,errors.new(message.string() ,) 
}
}
next_point.prev_value3=next_point.prev_value2  
next_point.prev_value2=next_point.prev_value1  
next_point.prev_value1=value_raw  
}
*value=math.float32frombits(value_raw ,)  
td.last_point=next_point  
return true ,unsafe { nil } 
}

fn (mut td Decoder) decode_point_id(code u8) (error, ) { match code {code_words.point_idxor4 {
td.last_point.prev_next_point_id1=td.read_bits4()  ^  td.last_point.prev_next_point_id1   
}
code_words.point_idxor8 {
td.last_point.prev_next_point_id1=i32(td.data[td.position ] ,)  ^  td.last_point.prev_next_point_id1   
td.position+=1  
}
code_words.point_idxor12 {
td.last_point.prev_next_point_id1=td.read_bits4()  ^  i32(td.data[td.position ] ,)  <<  4    ^  td.last_point.prev_next_point_id1   
td.position+=1  
}
code_words.point_idxor16 {
td.last_point.prev_next_point_id1=i32(td.data[td.position ] ,)  ^  i32(td.data[td.position  +  1  ] ,)  <<  8    ^  td.last_point.prev_next_point_id1   
td.position+=2  
}
code_words.point_idxor20 {
td.last_point.prev_next_point_id1=td.read_bits4()  ^  i32(td.data[td.position ] ,)  <<  4    ^  i32(td.data[td.position  +  1  ] ,)  <<  12    ^  td.last_point.prev_next_point_id1   
td.position+=2  
}
code_words.point_idxor24 {
td.last_point.prev_next_point_id1=i32(td.data[td.position ] ,)  ^  i32(td.data[td.position  +  1  ] ,)  <<  8    ^  i32(td.data[td.position  +  2  ] ,)  <<  16    ^  td.last_point.prev_next_point_id1   
td.position+=3  
}
code_words.point_idxor32 {
td.last_point.prev_next_point_id1=i32(td.data[td.position ] ,)  ^  i32(td.data[td.position  +  1  ] ,)  <<  8    ^  i32(td.data[td.position  +  2  ] ,)  <<  16    ^  i32(td.data[td.position  +  3  ] ,)  <<  24    ^  td.last_point.prev_next_point_id1   
td.position+=4  
}
else{
mut message:=strings.Builder{} 
message.write_string("invalid code received " ,)
message.write_string(strconv.itoa(int(code ,) ,) ,)
message.write_string(" at position " ,)
message.write_string(strconv.itoa(td.position ,) ,)
message.write_string(" with last position " ,)
message.write_string(strconv.itoa(td.last_position ,) ,)
return errors.new(message.string() ,) 
}
}
return unsafe { nil } 
}

fn decode7_bit_uint64(stream []u8, position &int) (u64, ) {stream=stream[*position .. ]  
mut value_1:=u64(stream[0 ] ,)  
if value_1  <  128  {
*position++
return value_1 
}
value_1^=u64(stream[1 ] ,)  <<  7   
if value_1  <  16384  {
*position+=2  
return value_1  ^  0x80  
}
value_1^=u64(stream[2 ] ,)  <<  14   
if value_1  <  2097152  {
*position+=3  
return value_1  ^  0x4080  
}
value_1^=u64(stream[3 ] ,)  <<  21   
if value_1  <  268435456  {
*position+=4  
return value_1  ^  0x204080  
}
value_1^=u64(stream[4 ] ,)  <<  28   
if value_1  <  34359738368  {
*position+=5  
return value_1  ^  0x10204080  
}
value_1^=u64(stream[5 ] ,)  <<  35   
if value_1  <  4398046511104  {
*position+=6  
return value_1  ^  0x810204080  
}
value_1^=u64(stream[6 ] ,)  <<  42   
if value_1  <  562949953421312  {
*position+=7  
return value_1  ^  0x40810204080  
}
value_1^=u64(stream[7 ] ,)  <<  49   
if value_1  <  72057594037927936  {
*position+=8  
return value_1  ^  0x2040810204080  
}
value_1^=u64(stream[8 ] ,)  <<  56   
*position+=9  
return value_1  ^  0x102040810204080  
}

fn abs(value_1 i64) (i64, ) {if value_1  <  0  {
return value_1  *  - 1   
}
return value_1 
}

//gocyclo:ig
fn (mut td Decoder) decode_timestamp(code_1 u8) (i64, ) {mut timestamp_1:=0 
 match code_1 {code_words.time_delta1_forward {
timestamp_1=td.prev_timestamp1  +  td.prev_time_delta1   
}
code_words.time_delta2_forward {
timestamp_1=td.prev_timestamp1  +  td.prev_time_delta2   
}
code_words.time_delta3_forward {
timestamp_1=td.prev_timestamp1  +  td.prev_time_delta3   
}
code_words.time_delta4_forward {
timestamp_1=td.prev_timestamp1  +  td.prev_time_delta4   
}
code_words.time_delta1_reverse {
timestamp_1=td.prev_timestamp1  -  td.prev_time_delta1   
}
code_words.time_delta2_reverse {
timestamp_1=td.prev_timestamp1  -  td.prev_time_delta2   
}
code_words.time_delta3_reverse {
timestamp_1=td.prev_timestamp1  -  td.prev_time_delta3   
}
code_words.time_delta4_reverse {
timestamp_1=td.prev_timestamp1  -  td.prev_time_delta4   
}
code_words.timestamp2 {
timestamp_1=td.prev_timestamp2  
}
else{
timestamp_1=td.prev_timestamp1  ^  i64(decode7_bit_uint64(td.data ,& td.position  ,) ,)   
}
}
mut min_delta:=abs(td.prev_timestamp1  -  timestamp_1  ,)  
if min_delta  <  td.prev_time_delta4   &&  min_delta  !=  td.prev_time_delta1    &&  min_delta  !=  td.prev_time_delta2    &&  min_delta  !=  td.prev_time_delta3   {
if min_delta  <  td.prev_time_delta1  {
td.prev_time_delta4=td.prev_time_delta3  
td.prev_time_delta3=td.prev_time_delta2  
td.prev_time_delta2=td.prev_time_delta1  
td.prev_time_delta1=min_delta  
}else if min_delta  <  td.prev_time_delta2  {
td.prev_time_delta4=td.prev_time_delta3  
td.prev_time_delta3=td.prev_time_delta2  
td.prev_time_delta2=min_delta  
}else if min_delta  <  td.prev_time_delta3  {
td.prev_time_delta4=td.prev_time_delta3  
td.prev_time_delta3=min_delta  
}else {
td.prev_time_delta4=min_delta  
}
}
td.prev_timestamp2=td.prev_timestamp1  
td.prev_timestamp1=timestamp_1  
return timestamp_1 
}

fn decode7_bit_uint32(stream []u8, position &int) (u32, ) {stream=stream[*position .. ]  
mut value_1:=u32(stream[0 ] ,)  
if value_1  <  128  {
*position++
return value_1 
}
value_1^=u32(stream[1 ] ,)  <<  7   
if value_1  <  16384  {
*position+=2  
return value_1  ^  0x80  
}
value_1^=u32(stream[2 ] ,)  <<  14   
if value_1  <  2097152  {
*position+=3  
return value_1  ^  0x4080  
}
value_1^=u32(stream[3 ] ,)  <<  21   
if value_1  <  268435456  {
*position+=4  
return value_1  ^  0x204080  
}
value_1^=u32(stream[4 ] ,)  <<  28   
*position+=5  
return value_1  ^  0x10204080  
}

fn (mut td Decoder) decode_state_flags(code_2 u8, nextPoint &pointMetadata) (u32, ) {mut state_flags:=0 
if code_2  ==  code_words.state_flags2  {
state_flags=nextPoint.prev_state_flags2  
}else {
state_flags=decode7_bit_uint32(td.data ,& td.position  ,)  
}
nextPoint.prev_state_flags2=nextPoint.prev_state_flags1  
nextPoint.prev_state_flags1=state_flags  
return state_flags 
}

fn (mut td Decoder) read_bit() (i32, ) {if td.bit_stream_count  ==  0  {
td.bit_stream_count=8  
td.bit_stream_cache=i32(td.data[td.position ] ,)  
td.position++
}
td.bitStreamCount--
return td.bit_stream_cache  >>  td.bit_stream_count   &  1  
}

fn (mut td Decoder) read_bits4() (i32, ) {return td.read_bit()  <<  3   |  td.read_bit()  <<  2    |  td.read_bit()  <<  1    |  td.read_bit()  
}

fn (mut td Decoder) read_bits5() (i32, ) {return td.read_bit()  <<  4   |  td.read_bit()  <<  3    |  td.read_bit()  <<  2    |  td.read_bit()  <<  1    |  td.read_bit()  
}
