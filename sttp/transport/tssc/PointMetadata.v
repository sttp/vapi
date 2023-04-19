module tssc
import math
const code_words=NOT_YET_IMPLEMENTED 
struct Go2VInlineStruct {
mut:
end_of_stream u8 
point_idxor4 u8 
point_idxor8 u8 
point_idxor12 u8 
point_idxor16 u8 
point_idxor20 u8 
point_idxor24 u8 
point_idxor32 u8 
time_delta1_forward u8 
time_delta2_forward u8 
time_delta3_forward u8 
time_delta4_forward u8 
time_delta1_reverse u8 
time_delta2_reverse u8 
time_delta3_reverse u8 
time_delta4_reverse u8 
timestamp2 u8 
time_xor7_bit u8 
state_flags2 u8 
state_flags7_bit32 u8 
value1 u8 
value2 u8 
value3 u8 
value_zero u8 
value_xor4 u8 
value_xor8 u8 
value_xor12 u8 
value_xor16 u8 
value_xor20 u8 
value_xor24 u8 
value_xor28 u8 
value_xor32 u8 
}
struct PointMetadata {
mut:
prev_next_point_id1 i32 
prev_state_flags1 u32 
prev_state_flags2 u32 
prev_value1 u32 
prev_value2 u32 
prev_value3 u32 
command_stats [32]u8 
commands_sent_since_last_change i32 
mode u8 
mode21 u8 
mode31 u8 
mode301 u8 
mode41 u8 
mode401 u8 
mode4001 u8 
startup_mode i32 
write_bits fn ( i32,  i32)  
read_bit fn () (i32, )  
read_bits5 fn () (i32, )  
}
fn new_point_metadata(writeBits fn ( i32,  i32) , readBit fn () (i32, ) ) (&PointMetadata, ) {return & PointMetadata{
mode:4  ,
mode41:code_words.value1  ,
mode401:code_words.value2  ,
mode4001:code_words.value3  ,
writeBits:writeBits  ,
readBit:readBit  ,
read_bits5:read_bits5  }  
}

pub fn (mut pm PointMetadata) write_code(code i32) (error, ) { match pm.mode {1 {
pm.write_bits(code ,5 ,)
}
2 {
if code  ==  i32(pm.mode21 ,)  {
pm.write_bits(1 ,1 ,)
}else {
pm.write_bits(code ,6 ,)
}
}
3 {
if code  ==  i32(pm.mode31 ,)  {
pm.write_bits(1 ,1 ,)
}else if code  ==  i32(pm.mode301 ,)  {
pm.write_bits(1 ,2 ,)
}else {
pm.write_bits(code ,7 ,)
}
}
4 {
if code  ==  i32(pm.mode41 ,)  {
pm.write_bits(1 ,1 ,)
}else if code  ==  i32(pm.mode401 ,)  {
pm.write_bits(1 ,2 ,)
}else if code  ==  i32(pm.mode4001 ,)  {
pm.write_bits(1 ,3 ,)
}else {
pm.write_bits(code ,8 ,)
}
}
else{
return errors.new("coding Error" ,) 
}
}
return pm.updated_code_statistics(code ,) 
}

pub fn (mut pm PointMetadata) read_code() (i32, error, ) {mut code_1:=0 
 match pm.mode {1 {
code_1=pm.read_bits5()  
}
2 {
if pm.read_bit()  ==  1  {
code_1=i32(pm.mode21 ,)  
}else {
code_1=pm.read_bits5()  
}
}
3 {
if pm.read_bit()  ==  1  {
code_1=i32(pm.mode31 ,)  
}else if pm.read_bit()  ==  1  {
code_1=i32(pm.mode301 ,)  
}else {
code_1=pm.read_bits5()  
}
}
4 {
if pm.read_bit()  ==  1  {
code_1=i32(pm.mode41 ,)  
}else if pm.read_bit()  ==  1  {
code_1=i32(pm.mode401 ,)  
}else if pm.read_bit()  ==  1  {
code_1=i32(pm.mode4001 ,)  
}else {
code_1=pm.read_bits5()  
}
}
else{
return 0 ,errors.new("unsupported compression mode" ,) 
}
}
mut err:=pm.updated_code_statistics(code_1 ,)  
return code_1 ,err 
}

fn (mut pm PointMetadata) updated_code_statistics(code_1 i32) (error, ) {pm.commandsSentSinceLastChange++
pm.commandStats[code_1 ]++
if pm.startup_mode  ==  0   &&  pm.commands_sent_since_last_change  >  5   {
pm.startupMode++
return pm.adapt_commands() 
}else if pm.startup_mode  ==  1   &&  pm.commands_sent_since_last_change  >  20   {
pm.startupMode++
return pm.adapt_commands() 
}else if pm.startup_mode  ==  2   &&  pm.commands_sent_since_last_change  >  100   {
return pm.adapt_commands() 
}
return unsafe { nil } 
}

fn min(lv i32) (i32, ) {if lv  <  rv  {
return lv 
}
if rv  <  lv  {
return rv 
}
return lv 
}

fn (mut pm PointMetadata) adapt_commands() (error, ) {mut code1:=0 
mut count1:=0 
mut code2:=u8(1 ) 
mut count2:=0 
mut code3:=u8(2 ) 
mut count3:=0 
mut total:=0 
for i:=0  ;i  <  pm.command_stats .len  ;i++ {
mut count:=i32(i32(pm.command_stats[i ] ,) ) 
pm.command_stats[i ]=0  
total+=count  
if count  >  count3  {
if count  >  count1  {
code3=code2  
count3=count2  
code2=code1  
count2=count1  
code1=u8(i ,)  
count1=count  
}else if count  >  count2  {
code3=code2  
count3=count2  
code2=u8(i ,)  
count2=count  
}else {
code3=u8(i ,)  
count3=count  
}
}
}
mut mode1_size:=i32(total  *  5  ) 
mut mode2_size:=i32(count1  +  (total  -  count1  )  *  6   ) 
mut mode3_size:=i32(count1  +  count2  *  2    +  (total  -  count1   -  count2  )  *  7   ) 
mut mode4_size:=i32(count1  +  count2  *  2    +  count3  *  3    +  (total  -  count1   -  count2   -  count3  )  *  8   ) 
mut min_size:=i32(math.max_int32 ) 
min_size=min(min_size ,mode1_size ,)  
min_size=min(min_size ,mode2_size ,)  
min_size=min(min_size ,mode3_size ,)  
min_size=min(min_size ,mode4_size ,)  
if min_size  ==  mode1_size  {
pm.mode=1  
}else if min_size  ==  mode2_size  {
pm.mode=2  
pm.mode21=code1  
}else if min_size  ==  mode3_size  {
pm.mode=3  
pm.mode31=code1  
pm.mode301=code2  
}else if min_size  ==  mode4_size  {
pm.mode=4  
pm.mode41=code1  
pm.mode401=code2  
pm.mode4001=code3  
}else {
if pm.write_bits  ==  unsafe { nil }  {
return errors.new("subscriber coding error" ,) 
}
return errors.new("publisher coding error" ,) 
}
pm.commands_sent_since_last_change=0  
return unsafe { nil } 
}
