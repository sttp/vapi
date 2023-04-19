module data
import strconv
import strings
import time
import github.com.araddon.dateparse
import github.com.shopspring.decimal
import github.com.sttp.goapi.sttp.guid
struct DataRow {
mut:
parent &DataTable 
values []T 
}
fn new_data_row(parent &DataTable) (&DataRow, ) {return & DataRow{
parent:parent  ,
values:[]{len: parent.column_count() }  }  
}

// Parent gets the parent DataTable of the Data
pub fn (mut dr DataRow) parent_1() (&DataTable, ) {return dr.parent 
}

fn (mut dr DataRow) get_column_index(columnName string) (int, error, ) {mut column:=dr.parent.column_by_name(columnName ,)  
if column  ==  unsafe { nil }  {
return - 1  ,errors.new("column name \""  +  columnName   +  "\" was not found in table \""   +  dr.parent.name()   +  "\""  ,) 
}
return column.index() ,unsafe { nil } 
}

fn (mut dr DataRow) validate_column_type(columnIndex int, read bool) (&DataColumn, error, ) {mut column:=dr.parent.column(columnIndex ,)  
if column  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("column index "  +  strconv.itoa(columnIndex ,)   +  " is out of range for table \""   +  dr.parent.name()   +  "\""  ,) 
}
if target_type  >  - 1    &&  column.@type()  !=  data_type_enum(target_type ,)   {
mut action:='' 
mut preposition:='' 
if read {
action="read"  
preposition="from"  
}else {
action="assign"  
preposition="to"  
}
return unsafe { nil } ,error(strconv.v_sprintf("cannot %s \"%s\" value %s DataColumn \"%s\" for table \"%s\", column data type is \"%s\"" ,action ,data_type_enum.string() ,preposition ,column.name() ,dr.parent.name() ,column.@type.string() ,) ,) 
}
if ! read   &&  column.computed()  {
return unsafe { nil } ,errors.new("cannot assign value to DataColumn \""  +  column.name()   +  "\" for table \""   +  dr.parent.name()   +  "\", column is computed with an expression"  ,) 
}
return column ,unsafe { nil } 
}

fn (mut dr DataRow) expression_tree(column &DataColumn) (&ExpressionTree, error, ) {mut column_index:=column.index()  
if dr.values[column_index ]  ==  unsafe { nil }  {
mut data_table:=column.parent()  
mut expression_tree_1,err:=generate_expression_tree(data_table ,column.expression() ,true ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed to parse expression defined for computed DataColumn \""  +  column.name()   +  "\" for table \""   +  dr.parent.name()   +  "\": "   +  err.error()  ,) 
}
dr.values[column_index ]=expression_tree_1  
return expression_tree_1 ,unsafe { nil } 
}
return dr.values[column_index ] ,unsafe { nil } 
}

//gocyclo:ig
fn convert_from_boolean(value bool, targetType DataTypeEnum) (T, error, ) {mut value_as_int:=0 
if value {
value_as_int=1  
}
 match targetType {data_type.string {
return strconv.format_bool(value ,) ,unsafe { nil } 
}
data_type.boolean {
return value ,unsafe { nil } 
}
data_type.single {
return f32(value_as_int ,) ,unsafe { nil } 
}
data_type.double {
return f64(value_as_int ,) ,unsafe { nil } 
}
data_type.decimal {
return decimal.new_from_int(i64(value_as_int ,) ,) ,unsafe { nil } 
}
data_type.int8 {
return i8(value_as_int ,) ,unsafe { nil } 
}
data_type.int16 {
return i16(value_as_int ,) ,unsafe { nil } 
}
data_type.int32 {
return i32(value_as_int ,) ,unsafe { nil } 
}
data_type.int64 {
return i64(value_as_int ,) ,unsafe { nil } 
}
data_type.uint8 {
return u8(value_as_int ,) ,unsafe { nil } 
}
data_type.uint16 {
return u16(value_as_int ,) ,unsafe { nil } 
}
data_type.uint32 {
return u32(value_as_int ,) ,unsafe { nil } 
}
data_type.uint64 {
return u64(value_as_int ,) ,unsafe { nil } 
}
data_type.date_time {
fallthrough 
}
data_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"Boolean\" expression value to \""  +  targetType.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_int32(value_1 i32, targetType_1 DataTypeEnum) (T, error, ) { match targetType_1 {data_type.string {
return strconv.format_int(i64(value_1 ,) ,10 ,) ,unsafe { nil } 
}
data_type.boolean {
return value_1  !=  0  ,unsafe { nil } 
}
data_type.single {
return f32(value_1 ,) ,unsafe { nil } 
}
data_type.double {
return f64(value_1 ,) ,unsafe { nil } 
}
data_type.decimal {
return decimal.new_from_int32(value_1 ,) ,unsafe { nil } 
}
data_type.int8 {
return i8(value_1 ,) ,unsafe { nil } 
}
data_type.int16 {
return i16(value_1 ,) ,unsafe { nil } 
}
data_type.int32 {
return value_1 ,unsafe { nil } 
}
data_type.int64 {
return i64(value_1 ,) ,unsafe { nil } 
}
data_type.uint8 {
return u8(value_1 ,) ,unsafe { nil } 
}
data_type.uint16 {
return u16(value_1 ,) ,unsafe { nil } 
}
data_type.uint32 {
return u32(value_1 ,) ,unsafe { nil } 
}
data_type.uint64 {
return u64(value_1 ,) ,unsafe { nil } 
}
data_type.date_time {
fallthrough 
}
data_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"Int32\" expression value to \""  +  targetType_1.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_int64(value_2 i64, targetType_2 DataTypeEnum) (T, error, ) { match targetType_2 {data_type.string {
return strconv.format_int(value_2 ,10 ,) ,unsafe { nil } 
}
data_type.boolean {
return value_2  !=  0  ,unsafe { nil } 
}
data_type.single {
return f32(value_2 ,) ,unsafe { nil } 
}
data_type.double {
return f64(value_2 ,) ,unsafe { nil } 
}
data_type.decimal {
return decimal.new_from_int(value_2 ,) ,unsafe { nil } 
}
data_type.int8 {
return i8(value_2 ,) ,unsafe { nil } 
}
data_type.int16 {
return i16(value_2 ,) ,unsafe { nil } 
}
data_type.int32 {
return i32(value_2 ,) ,unsafe { nil } 
}
data_type.int64 {
return value_2 ,unsafe { nil } 
}
data_type.uint8 {
return u8(value_2 ,) ,unsafe { nil } 
}
data_type.uint16 {
return u16(value_2 ,) ,unsafe { nil } 
}
data_type.uint32 {
return u32(value_2 ,) ,unsafe { nil } 
}
data_type.uint64 {
return u64(value_2 ,) ,unsafe { nil } 
}
data_type.date_time {
fallthrough 
}
data_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"Int64\" expression value to \""  +  targetType_2.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_decimal(value_3 decimal.Decimal, targetType_3 DataTypeEnum) (T, error, ) { match targetType_3 {data_type.string {
return value_3.string() ,unsafe { nil } 
}
data_type.boolean {
return ! value_3.equal(decimal.zero ,)  ,unsafe { nil } 
}
data_type.single {
mut f64,_:=value_3.float64()  
return f32(f64 ,) ,unsafe { nil } 
}
data_type.double {
mut f64_1,_:=value_3.float64()  
return f64_1 ,unsafe { nil } 
}
data_type.decimal {
return value_3 ,unsafe { nil } 
}
data_type.int8 {
return i8(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.int16 {
return i16(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.int32 {
return i32(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.int64 {
return value_3.int_part() ,unsafe { nil } 
}
data_type.uint8 {
return u8(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.uint16 {
return u16(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.uint32 {
return u32(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.uint64 {
return u64(value_3.int_part() ,) ,unsafe { nil } 
}
data_type.date_time {
fallthrough 
}
data_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"Decimal\" expression value to \""  +  targetType_3.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_double(value_4 f64, targetType_4 DataTypeEnum) (T, error, ) { match targetType_4 {data_type.string {
return strconv.format_float(value_4 ,`f` ,6 ,64 ,) ,unsafe { nil } 
}
data_type.boolean {
return value_4  !=  0.0  ,unsafe { nil } 
}
data_type.single {
return f32(value_4 ,) ,unsafe { nil } 
}
data_type.double {
return value_4 ,unsafe { nil } 
}
data_type.decimal {
return decimal.new_from_float(value_4 ,) ,unsafe { nil } 
}
data_type.int8 {
return i8(value_4 ,) ,unsafe { nil } 
}
data_type.int16 {
return i16(value_4 ,) ,unsafe { nil } 
}
data_type.int32 {
return i32(value_4 ,) ,unsafe { nil } 
}
data_type.int64 {
return i64(value_4 ,) ,unsafe { nil } 
}
data_type.uint8 {
return u8(value_4 ,) ,unsafe { nil } 
}
data_type.uint16 {
return u16(value_4 ,) ,unsafe { nil } 
}
data_type.uint32 {
return u32(value_4 ,) ,unsafe { nil } 
}
data_type.uint64 {
return u64(value_4 ,) ,unsafe { nil } 
}
data_type.date_time {
fallthrough 
}
data_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"Double\" expression value to \""  +  targetType_4.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_string(value_5 string, targetType_5 DataTypeEnum) (T, error, ) { match targetType_5 {data_type.string {
return value_5 ,unsafe { nil } 
}
data_type.boolean {
return strconv.parse_bool(value_5 ,) 
}
data_type.date_time {
mut dt,err_2:=dateparse.parse_any(value_5 ,)  
return dt.utc() ,err_2 
}
data_type.single {
mut f64,err_3:=strconv.parse_float(value_5 ,64 ,)  
return f32(f64 ,) ,err_3 
}
data_type.double {
return strconv.parse_float(value_5 ,64 ,) 
}
data_type.decimal {
return decimal.new_from_string(value_5 ,) 
}
data_type.guid {
return guid.parse(value_5 ,) 
}
data_type.int8 {
mut i,err_4:=strconv.parse_int(value_5 ,0 ,8 ,)  
return i8(i ,) ,err_4 
}
data_type.int16 {
mut i_1,err_5:=strconv.parse_int(value_5 ,0 ,16 ,)  
return i16(i_1 ,) ,err_5 
}
data_type.int32 {
mut i_2,err_6:=strconv.parse_int(value_5 ,0 ,32 ,)  
return i32(i_2 ,) ,err_6 
}
data_type.int64 {
mut i_3,err_7:=strconv.parse_int(value_5 ,0 ,64 ,)  
return i_3 ,err_7 
}
data_type.uint8 {
mut ui,err_8:=strconv.parse_uint(value_5 ,0 ,8 ,)  
return u8(ui ,) ,err_8 
}
data_type.uint16 {
mut ui_1,err_9:=strconv.parse_uint(value_5 ,0 ,16 ,)  
return u16(ui_1 ,) ,err_9 
}
data_type.uint32 {
mut ui_2,err_10:=strconv.parse_uint(value_5 ,0 ,32 ,)  
return u32(ui_2 ,) ,err_10 
}
data_type.uint64 {
mut ui_3,err_11:=strconv.parse_uint(value_5 ,0 ,64 ,)  
return ui_3 ,err_11 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_guid(value_6 guid.Guid, targetType_6 DataTypeEnum) (T, error, ) { match targetType_6 {data_type.string {
return value_6.string() ,unsafe { nil } 
}
data_type.guid {
return value_6 ,unsafe { nil } 
}
data_type.boolean {
fallthrough 
}
data_type.date_time {
fallthrough 
}
data_type.single {
fallthrough 
}
data_type.double {
fallthrough 
}
data_type.decimal {
fallthrough 
}
data_type.int8 {
fallthrough 
}
data_type.int16 {
fallthrough 
}
data_type.int32 {
fallthrough 
}
data_type.int64 {
fallthrough 
}
data_type.uint8 {
fallthrough 
}
data_type.uint16 {
fallthrough 
}
data_type.uint32 {
fallthrough 
}
data_type.uint64 {
return unsafe { nil } ,errors.new("cannot convert \"Guid\" expression value to \""  +  targetType_6.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

//gocyclo:ig
fn convert_from_date_time(value_7 time.Time, targetType_7 DataTypeEnum) (T, error, ) {mut seconds:=value_7.unix()  
 match targetType_7 {data_type.string {
return value_7.format(date_time_format ,) ,unsafe { nil } 
}
data_type.boolean {
return seconds  ==  0  ,unsafe { nil } 
}
data_type.date_time {
return value_7 ,unsafe { nil } 
}
data_type.single {
return f32(seconds ,) ,unsafe { nil } 
}
data_type.double {
return f64(seconds ,) ,unsafe { nil } 
}
data_type.decimal {
return decimal.new_from_int(seconds ,) ,unsafe { nil } 
}
data_type.int8 {
return i8(seconds ,) ,unsafe { nil } 
}
data_type.int16 {
return i16(seconds ,) ,unsafe { nil } 
}
data_type.int32 {
return i32(seconds ,) ,unsafe { nil } 
}
data_type.int64 {
return seconds ,unsafe { nil } 
}
data_type.uint8 {
return u8(seconds ,) ,unsafe { nil } 
}
data_type.uint16 {
return u16(seconds ,) ,unsafe { nil } 
}
data_type.uint32 {
return u32(seconds ,) ,unsafe { nil } 
}
data_type.uint64 {
return u64(seconds ,) ,unsafe { nil } 
}
data_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"DateTime\" expression value to \""  +  targetType_7.string()   +  "\" column"  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
}

fn (mut dr DataRow) get_computed_value(column_1 &DataColumn) (T, error, ) {mut expression_tree_1,err:=dr.expression_tree(column_1 ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
mut source_value,err_1:=expression_tree_1.evaluate(dr ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed to evaluate expression defined for computed DataColumn \""  +  column_1.name()   +  "\" for table \""   +  dr.parent.name()   +  "\": "   +  err_1.error()  ,) 
}
mut target_type:=column_1.@type()  
 match source_value.value_type() {expression_value_type.boolean {
return convert_from_boolean(source_value.boolean_value() ,target_type ,) 
}
expression_value_type.int32 {
return convert_from_int32(source_value.int32_value() ,targetType ,) 
}
expression_value_type.int64 {
return convert_from_int64(source_value.int64_value() ,targetType_1 ,) 
}
expression_value_type.decimal {
return convert_from_decimal(source_value.decimal_value() ,targetType_2 ,) 
}
expression_value_type.double {
return convert_from_double(source_value.double_value() ,targetType_3 ,) 
}
expression_value_type.string {
return convert_from_string(source_value.string_value() ,targetType_4 ,) 
}
expression_value_type.guid {
return convert_from_guid(source_value.guid_value() ,targetType_5 ,) 
}
expression_value_type.date_time {
return convert_from_date_time(source_value.date_time_value() ,targetType_6 ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

// Value reads the record value at the specified columnIn
pub fn (mut dr DataRow) value_8(columnIndex_1 int) (T, error, ) {mut column_2,err:=dr.validate_column_type(columnIndex_1 ,- 1  ,true ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
if column_2.computed() {
return dr.get_computed_value(column_2 ,) 
}
return dr.values[columnIndex_1 ] ,unsafe { nil } 
}

// ValueByName reads the record value for the specified columnN
pub fn (mut dr DataRow) value_by_name(columnName_1 string) (T, error, ) {mut index,err:=dr.get_column_index(columnName_1 ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
return dr.values[index ] ,unsafe { nil } 
}

// SetValue assigns the record value at the specified columnIn
pub fn (mut dr DataRow) set_value<T>(columnIndex_2 int, value T) (error, ) {mut _,err:=dr.validate_column_type(columnIndex_2 ,- 1  ,false ,)  
if err  !=  unsafe { nil }  {
return err 
}
dr.values[columnIndex_2 ]=value  
return unsafe { nil } 
}

// SetValueByName assigns the record value for the specified columnN
pub fn (mut dr DataRow) set_value_by_name<T>(columnName_2 string, value_1 T) (error, ) {mut index,err:=dr.get_column_index(columnName_2 ,)  
if err  !=  unsafe { nil }  {
return err 
}
return dr.set_value(index ,value_1 ,) 
}

// ColumnValueAsString reads the record value for the specified data co
pub fn (mut dr DataRow) column_value_as_string(column_2 &DataColumn) (string, ) {if column_2  ==  unsafe { nil }  {
return "" 
}
mut index:=column_2.index()  
 match column_2.@type() {data_type.string {
return dr.string_value_from_string(index ,) 
}
data_type.boolean {
return dr.string_value_from_boolean(index ,) 
}
data_type.date_time {
return dr.string_value_from_date_time(index ,) 
}
data_type.single {
return dr.string_value_from_single(index ,) 
}
data_type.double {
return dr.string_value_from_double(index ,) 
}
data_type.decimal {
return dr.string_value_from_decimal(index ,) 
}
data_type.guid {
return dr.string_value_from_guid(index ,) 
}
data_type.int8 {
return dr.string_value_from_int8(index ,) 
}
data_type.int16 {
return dr.string_value_from_int16(index ,) 
}
data_type.int32 {
return dr.string_value_from_int32(index ,) 
}
data_type.int64 {
return dr.string_value_from_int64(index ,) 
}
data_type.uint8 {
return dr.string_value_from_uint8(index ,) 
}
data_type.uint16 {
return dr.string_value_from_uint16(index ,) 
}
data_type.uint32 {
return dr.string_value_from_uint32(index ,) 
}
data_type.uint64 {
return dr.string_value_from_uint64(index ,) 
}
else{
return "" 
}
}
}

fn check_state(null bool, err error) (bool, string, ) {if err  !=  unsafe { nil }  {
return true ,"" 
}
if null {
return true ,"<NULL>" 
}
return false ,"" 
}

fn (mut dr DataRow) string_value_from_string(index int) (string, ) {mut value_2,null_1,err_1:=dr.string_value(index ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return value_2 
}

fn (mut dr DataRow) string_value_from_boolean(index_1 int) (string, ) {mut value_2,null_1,err_1:=dr.boolean_value(index_1 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_bool(value_2 ,) 
}

fn (mut dr DataRow) string_value_from_date_time(index_2 int) (string, ) {mut value_2,null_1,err_1:=dr.date_time_value(index_2 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return value_2.format(date_time_format ,) 
}

fn (mut dr DataRow) string_value_from_single(index_3 int) (string, ) {mut value_2,null_1,err_1:=dr.single_value(index_3 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_float(f64(value_2 ,) ,`f` ,6 ,32 ,) 
}

fn (mut dr DataRow) string_value_from_double(index_4 int) (string, ) {mut value_2,null_1,err_1:=dr.double_value(index_4 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_float(value_2 ,`f` ,6 ,64 ,) 
}

fn (mut dr DataRow) string_value_from_decimal(index_5 int) (string, ) {mut value_2,null_1,err_1:=dr.decimal_value(index_5 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return value_2.string() 
}

fn (mut dr DataRow) string_value_from_guid(index_6 int) (string, ) {mut value_2,null_1,err_1:=dr.guid_value(index_6 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return value_2.string() 
}

fn (mut dr DataRow) string_value_from_int8(index_7 int) (string, ) {mut value_2,null_1,err_1:=dr.int8_value(index_7 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_int(i64(value_2 ,) ,10 ,) 
}

fn (mut dr DataRow) string_value_from_int16(index_8 int) (string, ) {mut value_2,null_1,err_1:=dr.int16_value(index_8 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_int(i64(value_2 ,) ,10 ,) 
}

fn (mut dr DataRow) string_value_from_int32(index_9 int) (string, ) {mut value_2,null_1,err_1:=dr.int32_value(index_9 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_int(i64(value_2 ,) ,10 ,) 
}

fn (mut dr DataRow) string_value_from_int64(index_10 int) (string, ) {mut value_2,null_1,err_1:=dr.int64_value(index_10 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_int(value_2 ,10 ,) 
}

fn (mut dr DataRow) string_value_from_uint8(index_11 int) (string, ) {mut value_2,null_1,err_1:=dr.uint8_value(index_11 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_uint(u64(value_2 ,) ,10 ,) 
}

fn (mut dr DataRow) string_value_from_uint16(index_12 int) (string, ) {mut value_2,null_1,err_1:=dr.uint16_value(index_12 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_uint(u64(value_2 ,) ,10 ,) 
}

fn (mut dr DataRow) string_value_from_uint32(index_13 int) (string, ) {mut value_2,null_1,err_1:=dr.uint32_value(index_13 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_uint(u64(value_2 ,) ,10 ,) 
}

fn (mut dr DataRow) string_value_from_uint64(index_14 int) (string, ) {mut value_2,null_1,err_1:=dr.uint64_value(index_14 ,)  
mut invalid,result:=check_state(null_1 ,err_1 ,) 
if invalid {
return result 
}
return strconv.format_uint(value_2 ,10 ,) 
}

// ValueAsString reads the record value at the specified columnIndex converted to a str
pub fn (mut dr DataRow) value_as_string(columnIndex_3 int) (string, ) {return dr.column_value_as_string(dr.parent.column(columnIndex_3 ,) ,) 
}

// ValueAsStringByName reads the record value for the specified columnName converted to a str
pub fn (mut dr DataRow) value_as_string_by_name(columnName_3 string) (string, ) {return dr.column_value_as_string(dr.parent.column_by_name(columnName_3 ,) ,) 
}

// StringValue gets the record value at the specified columnIndex cast as a str
pub fn (mut dr DataRow) string_value(columnIndex_4 int) (string, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_4 ,int(data_type.string ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return "" ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return "" ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return "" ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_4 ]  
if value_2  ==  unsafe { nil }  {
return "" ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// StringValueByName gets the record value for the specified columnName cast as a str
pub fn (mut dr DataRow) string_value_by_name(columnName_4 string) (string, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_4 ,)  
if err_1  !=  unsafe { nil }  {
return "" ,false ,err_1 
}
return dr.string_value(index_15 ,) 
}

// BooleanValue gets the record value at the specified columnIndex cast as a b
pub fn (mut dr DataRow) boolean_value(columnIndex_5 int) (bool, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_5 ,int(data_type.boolean ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return false ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return false ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return false ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_5 ]  
if value_2  ==  unsafe { nil }  {
return false ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// BooleanValueByName gets the record value for the specified columnName cast as a b
pub fn (mut dr DataRow) boolean_value_by_name(columnName_5 string) (bool, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_5 ,)  
if err_1  !=  unsafe { nil }  {
return false ,false ,err_1 
}
return dr.boolean_value(index_15 ,) 
}

// DateTimeValue gets the record value at the specified columnIndex cast as a time.T
pub fn (mut dr DataRow) date_time_value(columnIndex_6 int) (time.Time, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_6 ,int(data_type.date_time ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return time.Time{} ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return time.Time{} ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return time.Time{} ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_6 ]  
if value_2  ==  unsafe { nil }  {
return time.Time{} ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// DateTimeValueByName gets the record value for the specified columnName cast as a time.T
pub fn (mut dr DataRow) date_time_value_by_name(columnName_6 string) (time.Time, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_6 ,)  
if err_1  !=  unsafe { nil }  {
return time.Time{} ,false ,err_1 
}
return dr.date_time_value(index_15 ,) 
}

// SingleValue gets the record value at the specified columnIndex cast as a floa
pub fn (mut dr DataRow) single_value(columnIndex_7 int) (f32, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_7 ,int(data_type.single ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0.0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0.0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0.0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_7 ]  
if value_2  ==  unsafe { nil }  {
return 0.0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// SingleValueByName gets the record value for the specified columnName cast as a floa
pub fn (mut dr DataRow) single_value_by_name(columnName_7 string) (f32, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_7 ,)  
if err_1  !=  unsafe { nil }  {
return 0.0 ,false ,err_1 
}
return dr.single_value(index_15 ,) 
}

// DoubleValue gets the record value at the specified columnIndex cast as a floa
pub fn (mut dr DataRow) double_value(columnIndex_8 int) (f64, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_8 ,int(data_type.double ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0.0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0.0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0.0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_8 ]  
if value_2  ==  unsafe { nil }  {
return 0.0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// DoubleValueByName gets the record value for the specified columnName cast as a floa
pub fn (mut dr DataRow) double_value_by_name(columnName_8 string) (f64, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_8 ,)  
if err_1  !=  unsafe { nil }  {
return 0.0 ,false ,err_1 
}
return dr.double_value(index_15 ,) 
}

// DecimalValue gets the record value at the specified columnIndex cast as a decimal.Deci
pub fn (mut dr DataRow) decimal_value(columnIndex_9 int) (decimal.Decimal, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_9 ,int(data_type.decimal ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return decimal.zero ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return decimal.zero ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return decimal.zero ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_9 ]  
if value_2  ==  unsafe { nil }  {
return decimal.zero ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// DecimalValueByName gets the record value for the specified columnName cast as a decimal.Deci
pub fn (mut dr DataRow) decimal_value_by_name(columnName_9 string) (decimal.Decimal, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_9 ,)  
if err_1  !=  unsafe { nil }  {
return decimal.zero ,false ,err_1 
}
return dr.decimal_value(index_15 ,) 
}

// GuidValue gets the record value at the specified columnIndex cast as a guid.G
pub fn (mut dr DataRow) guid_value(columnIndex_10 int) (guid.Guid, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_10 ,int(data_type.guid ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return guid.Guid{} ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return guid.Guid{} ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return guid.Guid{} ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_10 ]  
if value_2  ==  unsafe { nil }  {
return guid.Guid{} ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// GuidValueByName gets the record value for the specified columnName cast as a guid.G
pub fn (mut dr DataRow) guid_value_by_name(columnName_10 string) (guid.Guid, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_10 ,)  
if err_1  !=  unsafe { nil }  {
return guid.Guid{} ,false ,err_1 
}
return dr.guid_value(index_15 ,) 
}

// Int8Value gets the record value at the specified columnIndex cast as an i
pub fn (mut dr DataRow) int8_value(columnIndex_11 int) (i8, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_11 ,int(data_type.int8 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_11 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// Int8ValueByName gets the record value for the specified columnName cast as an i
pub fn (mut dr DataRow) int8_value_by_name(columnName_11 string) (i8, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_11 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.int8_value(index_15 ,) 
}

// Int16Value gets the record value at the specified columnIndex cast as an in
pub fn (mut dr DataRow) int16_value(columnIndex_12 int) (i16, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_12 ,int(data_type.int16 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_12 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// Int16ValueByName gets the record value for the specified columnName cast as an in
pub fn (mut dr DataRow) int16_value_by_name(columnName_12 string) (i16, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_12 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.int16_value(index_15 ,) 
}

// Int32Value gets the record value at the specified columnIndex cast as an in
pub fn (mut dr DataRow) int32_value(columnIndex_13 int) (i32, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_13 ,int(data_type.int32 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_13 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// Int32ValueByName gets the record value for the specified columnName cast as an in
pub fn (mut dr DataRow) int32_value_by_name(columnName_13 string) (i32, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_13 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.int32_value(index_15 ,) 
}

// Int64Value gets the record value at the specified columnIndex cast as an in
pub fn (mut dr DataRow) int64_value(columnIndex_14 int) (i64, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_14 ,int(data_type.int64 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_14 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// Int64ValueByName gets the record value for the specified columnName cast as an in
pub fn (mut dr DataRow) int64_value_by_name(columnName_14 string) (i64, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_14 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.int64_value(index_15 ,) 
}

// UInt8Value gets the record value at the specified columnIndex cast as an ui
pub fn (mut dr DataRow) uint8_value(columnIndex_15 int) (u8, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_15 ,int(data_type.uint8 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_15 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// UInt8ValueByName gets the record value for the specified columnName cast as an ui
pub fn (mut dr DataRow) uint8_value_by_name(columnName_15 string) (u8, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_15 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.uint8_value(index_15 ,) 
}

// UInt16Value gets the record value at the specified columnIndex cast as an uin
pub fn (mut dr DataRow) uint16_value(columnIndex_16 int) (u16, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_16 ,int(data_type.uint16 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_16 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// UInt16ValueByName gets the record value for the specified columnName cast as an uin
pub fn (mut dr DataRow) uint16_value_by_name(columnName_16 string) (u16, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_16 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.uint16_value(index_15 ,) 
}

// UInt32Value gets the record value at the specified columnIndex cast as an uin
pub fn (mut dr DataRow) uint32_value(columnIndex_17 int) (u32, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_17 ,int(data_type.uint32 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_17 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// UInt32ValueByName gets the record value for the specified columnName cast as an uin
pub fn (mut dr DataRow) uint32_value_by_name(columnName_17 string) (u32, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_17 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.uint32_value(index_15 ,) 
}

// UInt64Value gets the record value at the specified columnIndex cast as an uin
pub fn (mut dr DataRow) uint64_value(columnIndex_18 int) (u64, bool, error, ) {mut column_3,err_1:=dr.validate_column_type(columnIndex_18 ,int(data_type.uint64 ,) ,true ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
if column_3.computed() {
mut value_2,err_2:=dr.get_computed_value(column_3 ,)  
if err_2  !=  unsafe { nil }  {
return 0 ,false ,err_2 
}
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}
mut value_2:=dr.values[columnIndex_18 ]  
if value_2  ==  unsafe { nil }  {
return 0 ,true ,unsafe { nil } 
}
return value_2 ,false ,unsafe { nil } 
}

// UInt64ValueByName gets the record value for the specified columnName cast as an uin
pub fn (mut dr DataRow) uint64_value_by_name(columnName_18 string) (u64, bool, error, ) {mut index_15,err_1:=dr.get_column_index(columnName_18 ,)  
if err_1  !=  unsafe { nil }  {
return 0 ,false ,err_1 
}
return dr.uint64_value(index_15 ,) 
}

// String get a representation of the DataRow as a str
pub fn (mut dr DataRow) string() (string, ) {mut image:=strings.Builder{} 
image.write_rune(`[` ,)
for i:=0  ;i  <  dr.parent.column_count()  ;i++ {
if i  >  0  {
image.write_string(", " ,)
}
mut string_column:=dr.parent.column.@type()  ==  data_type.string   
if string_column {
image.write_rune(`"` ,)
}
image.write_string(dr.value_as_string(i ,) ,)
if string_column {
image.write_rune(`"` ,)
}
}
image.write_rune(`]` ,)
return image.string() 
}

fn null_compare(leftHasValue bool) (int, ) {if ! leftHasValue   &&  ! right_has_value   {
return 0 
}
if leftHasValue {
return 1 
}
return - 1  
}

// CompareDataRowColumns returns an integer comparing two DataRow column values for the specified column in
pub fn compare_data_row_columns(leftRow &DataRow, columnIndex_19 int, exactMatch bool) (int, error, ) {mut left_column:=leftRow.parent.column(columnIndex_19 ,)  
mut right_column:=right_row.parent.column(columnIndex_19 ,)  
if left_column  ==  unsafe { nil }   ||  right_column  ==  unsafe { nil }   {
return 0 ,errors.new("cannot compare, column index out of range" ,) 
}
mut left_type:=left_column.@type()  
mut right_type:=right_column.@type()  
if left_type  !=  right_type  {
return 0 ,errors.new("cannot compare, types do not match" ,) 
}
 match left_type {data_type.string {
mut left_value,left_null,left_err:=leftRow.string_value(columnIndex_19 ,)  
mut right_value,right_null,right_err:=right_row.string_value(columnIndex_19 ,)  
mut left_has_value:=! left_null   &&  left_err  ==  unsafe { nil }    
mut right_has_value:=! right_null   &&  right_err  ==  unsafe { nil }    
if left_has_value  &&  right_has_value  {
if exactMatch {
return left_value .compare(right_value ,) ,unsafe { nil } 
}
return left_value .to_upper() .compare(right_value .to_upper() ,) ,unsafe { nil } 
}
return null_compare(left_has_value ,right_has_value ,) ,unsafe { nil } 
}
data_type.boolean {
mut left_value_1,left_null_1,left_err_1:=leftRow.boolean_value(columnIndex_19 ,)  
mut right_value_1,right_null_1,right_err_1:=right_row.boolean_value(columnIndex_19 ,)  
mut left_has_value_1:=! left_null_1   &&  left_err_1  ==  unsafe { nil }    
mut right_has_value_1:=! right_null_1   &&  right_err_1  ==  unsafe { nil }    
if left_has_value_1  &&  right_has_value_1  {
if left_value_1  &&  ! right_value_1   {
return - 1  ,unsafe { nil } 
}
if ! left_value_1   &&  right_value_1  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_1 ,right_has_value_1 ,) ,unsafe { nil } 
}
data_type.date_time {
mut left_value_2,left_null_2,left_err_2:=leftRow.date_time_value(columnIndex_19 ,)  
mut right_value_2,right_null_2,right_err_2:=right_row.date_time_value(columnIndex_19 ,)  
mut left_has_value_2:=! left_null_2   &&  left_err_2  ==  unsafe { nil }    
mut right_has_value_2:=! right_null_2   &&  right_err_2  ==  unsafe { nil }    
if left_has_value_2  &&  right_has_value_2  {
if left_value_2.before(right_value_2 ,) {
return - 1  ,unsafe { nil } 
}
if left_value_2.after(right_value_2 ,) {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_2 ,right_has_value_2 ,) ,unsafe { nil } 
}
data_type.single {
mut left_value_3,left_null_3,left_err_3:=leftRow.single_value(columnIndex_19 ,)  
mut right_value_3,right_null_3,right_err_3:=right_row.single_value(columnIndex_19 ,)  
mut left_has_value_3:=! left_null_3   &&  left_err_3  ==  unsafe { nil }    
mut right_has_value_3:=! right_null_3   &&  right_err_3  ==  unsafe { nil }    
if left_has_value_3  &&  right_has_value_3  {
if left_value_3  <  right_value_3  {
return - 1  ,unsafe { nil } 
}
if left_value_3  >  right_value_3  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_3 ,right_has_value_3 ,) ,unsafe { nil } 
}
data_type.double {
mut left_value_4,left_null_4,left_err_4:=leftRow.double_value(columnIndex_19 ,)  
mut right_value_4,right_null_4,right_err_4:=right_row.double_value(columnIndex_19 ,)  
mut left_has_value_4:=! left_null_4   &&  left_err_4  ==  unsafe { nil }    
mut right_has_value_4:=! right_null_4   &&  right_err_4  ==  unsafe { nil }    
if left_has_value_4  &&  right_has_value_4  {
if left_value_4  <  right_value_4  {
return - 1  ,unsafe { nil } 
}
if left_value_4  >  right_value_4  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_4 ,right_has_value_4 ,) ,unsafe { nil } 
}
data_type.decimal {
mut left_value_5,left_null_5,left_err_5:=leftRow.decimal_value(columnIndex_19 ,)  
mut right_value_5,right_null_5,right_err_5:=right_row.decimal_value(columnIndex_19 ,)  
mut left_has_value_5:=! left_null_5   &&  left_err_5  ==  unsafe { nil }    
mut right_has_value_5:=! right_null_5   &&  right_err_5  ==  unsafe { nil }    
if left_has_value_5  &&  right_has_value_5  {
if left_value_5.cmp(right_value_5 ,)  <  0  {
return - 1  ,unsafe { nil } 
}
if left_value_5.cmp(right_value_5 ,)  >  0  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_5 ,right_has_value_5 ,) ,unsafe { nil } 
}
data_type.guid {
mut left_value_6,left_null_6,left_err_6:=leftRow.guid_value(columnIndex_19 ,)  
mut right_value_6,right_null_6,right_err_6:=right_row.guid_value(columnIndex_19 ,)  
mut left_has_value_6:=! left_null_6   &&  left_err_6  ==  unsafe { nil }    
mut right_has_value_6:=! right_null_6   &&  right_err_6  ==  unsafe { nil }    
if left_has_value_6  &&  right_has_value_6  {
if left_value_6.compare(right_value_6 ,)  <  0  {
return - 1  ,unsafe { nil } 
}
if left_value_6.compare(right_value_6 ,)  >  0  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_6 ,right_has_value_6 ,) ,unsafe { nil } 
}
data_type.int8 {
mut left_value_7,left_null_7,left_err_7:=leftRow.int8_value(columnIndex_19 ,)  
mut right_value_7,right_null_7,right_err_7:=right_row.int8_value(columnIndex_19 ,)  
mut left_has_value_7:=! left_null_7   &&  left_err_7  ==  unsafe { nil }    
mut right_has_value_7:=! right_null_7   &&  right_err_7  ==  unsafe { nil }    
if left_has_value_7  &&  right_has_value_7  {
if left_value_7  <  right_value_7  {
return - 1  ,unsafe { nil } 
}
if left_value_7  >  right_value_7  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_7 ,right_has_value_7 ,) ,unsafe { nil } 
}
data_type.int16 {
mut left_value_8,left_null_8,left_err_8:=leftRow.int16_value(columnIndex_19 ,)  
mut right_value_8,right_null_8,right_err_8:=right_row.int16_value(columnIndex_19 ,)  
mut left_has_value_8:=! left_null_8   &&  left_err_8  ==  unsafe { nil }    
mut right_has_value_8:=! right_null_8   &&  right_err_8  ==  unsafe { nil }    
if left_has_value_8  &&  right_has_value_8  {
if left_value_8  <  right_value_8  {
return - 1  ,unsafe { nil } 
}
if left_value_8  >  right_value_8  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_8 ,right_has_value_8 ,) ,unsafe { nil } 
}
data_type.int32 {
mut left_value_9,left_null_9,left_err_9:=leftRow.int32_value(columnIndex_19 ,)  
mut right_value_9,right_null_9,right_err_9:=right_row.int32_value(columnIndex_19 ,)  
mut left_has_value_9:=! left_null_9   &&  left_err_9  ==  unsafe { nil }    
mut right_has_value_9:=! right_null_9   &&  right_err_9  ==  unsafe { nil }    
if left_has_value_9  &&  right_has_value_9  {
if left_value_9  <  right_value_9  {
return - 1  ,unsafe { nil } 
}
if left_value_9  >  right_value_9  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_9 ,right_has_value_9 ,) ,unsafe { nil } 
}
data_type.int64 {
mut left_value_10,left_null_10,left_err_10:=leftRow.int64_value(columnIndex_19 ,)  
mut right_value_10,right_null_10,right_err_10:=right_row.int64_value(columnIndex_19 ,)  
mut left_has_value_10:=! left_null_10   &&  left_err_10  ==  unsafe { nil }    
mut right_has_value_10:=! right_null_10   &&  right_err_10  ==  unsafe { nil }    
if left_has_value_10  &&  right_has_value_10  {
if left_value_10  <  right_value_10  {
return - 1  ,unsafe { nil } 
}
if left_value_10  >  right_value_10  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_10 ,right_has_value_10 ,) ,unsafe { nil } 
}
data_type.uint8 {
mut left_value_11,left_null_11,left_err_11:=leftRow.uint8_value(columnIndex_19 ,)  
mut right_value_11,right_null_11,right_err_11:=right_row.uint8_value(columnIndex_19 ,)  
mut left_has_value_11:=! left_null_11   &&  left_err_11  ==  unsafe { nil }    
mut right_has_value_11:=! right_null_11   &&  right_err_11  ==  unsafe { nil }    
if left_has_value_11  &&  right_has_value_11  {
if left_value_11  <  right_value_11  {
return - 1  ,unsafe { nil } 
}
if left_value_11  >  right_value_11  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_11 ,right_has_value_11 ,) ,unsafe { nil } 
}
data_type.uint16 {
mut left_value_12,left_null_12,left_err_12:=leftRow.uint16_value(columnIndex_19 ,)  
mut right_value_12,right_null_12,right_err_12:=right_row.uint16_value(columnIndex_19 ,)  
mut left_has_value_12:=! left_null_12   &&  left_err_12  ==  unsafe { nil }    
mut right_has_value_12:=! right_null_12   &&  right_err_12  ==  unsafe { nil }    
if left_has_value_12  &&  right_has_value_12  {
if left_value_12  <  right_value_12  {
return - 1  ,unsafe { nil } 
}
if left_value_12  >  right_value_12  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_12 ,right_has_value_12 ,) ,unsafe { nil } 
}
data_type.uint32 {
mut left_value_13,left_null_13,left_err_13:=leftRow.uint32_value(columnIndex_19 ,)  
mut right_value_13,right_null_13,right_err_13:=right_row.uint32_value(columnIndex_19 ,)  
mut left_has_value_13:=! left_null_13   &&  left_err_13  ==  unsafe { nil }    
mut right_has_value_13:=! right_null_13   &&  right_err_13  ==  unsafe { nil }    
if left_has_value_13  &&  right_has_value_13  {
if left_value_13  <  right_value_13  {
return - 1  ,unsafe { nil } 
}
if left_value_13  >  right_value_13  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_13 ,right_has_value_13 ,) ,unsafe { nil } 
}
data_type.uint64 {
mut left_value_14,left_null_14,left_err_14:=leftRow.uint64_value(columnIndex_19 ,)  
mut right_value_14,right_null_14,right_err_14:=right_row.uint64_value(columnIndex_19 ,)  
mut left_has_value_14:=! left_null_14   &&  left_err_14  ==  unsafe { nil }    
mut right_has_value_14:=! right_null_14   &&  right_err_14  ==  unsafe { nil }    
if left_has_value_14  &&  right_has_value_14  {
if left_value_14  <  right_value_14  {
return - 1  ,unsafe { nil } 
}
if left_value_14  >  right_value_14  {
return 1 ,unsafe { nil } 
}
return 0 ,unsafe { nil } 
}
return null_compare(left_has_value_14 ,right_has_value_14 ,) ,unsafe { nil } 
}
else{
return 0 ,errors.new("unexpected column data type encountered" ,) 
}
}
}
