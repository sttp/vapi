module data
import strconv
import time
import github.com.araddon.dateparse
import github.com.shopspring.decimal
import github.com.sttp.goapi.sttp.guid
const (
debug=bool(true )
true=&ValueExpression(new_value_expression_1(expression_value_type.boolean ,true ,) )
false=&ValueExpression(new_value_expression_1(expression_value_type.boolean ,false ,) )
empty_string=&ValueExpression(new_value_expression_1(expression_value_type.string ,"" ,) )
)
struct ValueExpression {
mut:
value T 
value_type ExpressionValueTypeEnum 
}
fn new_value_expression_1<T>(valueType_1 ExpressionValueTypeEnum, value_1 T) (&ValueExpression, ) {if debug {
return new_value_expression(valueType_1 ,value_1 ,) 
}
return & ValueExpression{
value_1:value_1  ,
valueType_1:valueType_1  }  
}

// NewValueExpression creates a new value express
pub fn new_value_expression<T>(valueType ExpressionValueTypeEnum, value T) (&ValueExpression, ) {if value  !=  unsafe { nil }  {
 match valueType {expression_value_type.boolean {
mut _,ok:=value 
if ! ok  {
panic("cannot create Boolean value expression; value is not bool" ,)
}
}
expression_value_type.int32 {
mut _,ok_1:=value 
if ! ok_1  {
panic("cannot create Int32 value expression; value is not int32" ,)
}
}
expression_value_type.int64 {
mut _,ok_2:=value 
if ! ok_2  {
panic("cannot create Int64 value expression; value is not int64" ,)
}
}
expression_value_type.decimal {
mut _,ok_3:=value 
if ! ok_3  {
panic("cannot create Decimal value expression; value is not decimal.Decimal" ,)
}
}
expression_value_type.double {
mut _,ok_4:=value 
if ! ok_4  {
panic("cannot create Double value expression; value is not float64" ,)
}
}
expression_value_type.string {
mut _,ok_5:=value 
if ! ok_5  {
panic("cannot create String value expression; value is not string" ,)
}
}
expression_value_type.guid {
mut _,ok_6:=value 
if ! ok_6  {
panic("cannot create Guid value expression; value is not guid.Guid" ,)
}
}
expression_value_type.date_time {
mut _,ok_7:=value 
if ! ok_7  {
panic("cannot create DateTime value expression; value is not time.Time" ,)
}
}
else{
panic("cannot create new value expression; unexpected expression value type: 0x"  +  strconv.format_int(i64(valueType ,) ,16 ,)  ,)
}
}
}
if debug {
return & ValueExpression{
value:value  ,
valueType:valueType  }  
}
return new_value_expression(valueType ,value ,) 
}

// Type gets expression type of the ValueExpress
pub fn (mut _ ValueExpression) @type() (ExpressionTypeEnum, ) {return expression_type.value 
}

// Value gets the value of a ValueExpress
pub fn (mut ve ValueExpression) value_2() (T, ) {return ve.value 
}

// ValueType gets data type of the value of a ValueExpress
pub fn (mut ve ValueExpression) value_type() (ExpressionValueTypeEnum, ) {return ve.value_type 
}

// String gets the ValueExpression value as a str
pub fn (mut ve ValueExpression) string() (string, ) { match ve.value_type {expression_value_type.boolean {
return strconv.format_bool(ve.boolean_value() ,) 
}
expression_value_type.int32 {
return strconv.format_int(i64(ve.int32_value() ,) ,10 ,) 
}
expression_value_type.int64 {
return strconv.format_int(ve.int64_value() ,10 ,) 
}
expression_value_type.decimal {
return ve.decimal_value.string() 
}
expression_value_type.double {
return strconv.format_float(ve.double_value() ,`f` ,6 ,64 ,) 
}
expression_value_type.string {
return ve.string_value() 
}
expression_value_type.guid {
return ve.guid_value.string() 
}
expression_value_type.date_time {
return ve.date_time_value.format(date_time_format ,) 
}
else{
return "" 
}
}
}

// IsNull gets a flag that determines if the ValueExpression value is n
pub fn (mut ve ValueExpression) is_null() (bool, ) {return ve.value  ==  unsafe { nil }  
}

// NullValue gets the target expression value type with a value of 
pub fn null_value(targetValueType ExpressionValueTypeEnum) (&ValueExpression, ) { match targetValueType {expression_value_type.boolean {
return new_value_expression_1(expression_value_type.boolean ,unsafe { nil } ,) 
}
expression_value_type.int32 {
return new_value_expression_1(expression_value_type.int32 ,unsafe { nil } ,) 
}
expression_value_type.int64 {
return new_value_expression_1(expression_value_type.int64 ,unsafe { nil } ,) 
}
expression_value_type.decimal {
return new_value_expression_1(expression_value_type.decimal ,unsafe { nil } ,) 
}
expression_value_type.double {
return new_value_expression_1(expression_value_type.double ,unsafe { nil } ,) 
}
expression_value_type.string {
return new_value_expression_1(expression_value_type.string ,unsafe { nil } ,) 
}
expression_value_type.guid {
return new_value_expression_1(expression_value_type.guid ,unsafe { nil } ,) 
}
expression_value_type.date_time {
return new_value_expression_1(expression_value_type.date_time ,unsafe { nil } ,) 
}
else{
return new_value_expression_1(expression_value_type.undefined ,unsafe { nil } ,) 
}
}
}

fn (mut ve ValueExpression) integer_value(defaultValue int) (int, ) { match ve.value_type() {expression_value_type.boolean {
return ve.boolean_value_as_int() 
}
expression_value_type.int32 {
return int(ve.int32_value() ,) 
}
expression_value_type.int64 {
return int(ve.int64_value() ,) 
}
else{
return defaultValue 
}
}
}

fn (mut ve ValueExpression) validate_value_type(valueType_1 ExpressionValueTypeEnum) (error, ) {if valueType_1  !=  ve.value_type  {
return error(strconv.v_sprintf("cannot read expression value as \"%s\", type is \"%s\"" ,valueType_1.string() ,ve.value_type.string() ,) ,) 
}
return unsafe { nil } 
}

// BooleanValue gets the ValueExpression value cast as a b
pub fn (mut ve ValueExpression) boolean_value() (bool, error, ) {mut err:=ve.validate_value_type(expression_value_type.boolean ,)  
if err  !=  unsafe { nil }  {
return false ,err 
}
return ve.boolean_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) boolean_value_1() (bool, ) {if ve.value  ==  unsafe { nil }  {
return false 
}
return ve.value 
}

fn (mut ve ValueExpression) boolean_value_as_int() (int, ) {if ve.boolean_value() {
return 1 
}
return 0 
}

// Int32Value gets the ValueExpression value cast as an in
pub fn (mut ve ValueExpression) int32_value() (i32, error, ) {mut err:=ve.validate_value_type(expression_value_type.int32 ,)  
if err  !=  unsafe { nil }  {
return 0 ,err 
}
return ve.int32_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) int32_value_1() (i32, ) {if ve.value  ==  unsafe { nil }  {
return 0 
}
return ve.value 
}

// Int64Value gets the ValueExpression value cast as an in
pub fn (mut ve ValueExpression) int64_value() (i64, error, ) {mut err:=ve.validate_value_type(expression_value_type.int64 ,)  
if err  !=  unsafe { nil }  {
return 0 ,err 
}
return ve.int64_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) int64_value_1() (i64, ) {if ve.value  ==  unsafe { nil }  {
return 0 
}
return ve.value 
}

// DecimalValue gets the ValueExpression value cast as a decimal.Deci
pub fn (mut ve ValueExpression) decimal_value() (decimal.Decimal, error, ) {mut err:=ve.validate_value_type(expression_value_type.decimal ,)  
if err  !=  unsafe { nil }  {
return decimal.zero ,err 
}
return ve.decimal_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) decimal_value_1() (decimal.Decimal, ) {if ve.value  ==  unsafe { nil }  {
return decimal.zero 
}
return ve.value 
}

// DoubleValue gets the ValueExpression value cast as a floa
pub fn (mut ve ValueExpression) double_value() (f64, error, ) {mut err:=ve.validate_value_type(expression_value_type.double ,)  
if err  !=  unsafe { nil }  {
return 0.0 ,err 
}
return ve.double_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) double_value_1() (f64, ) {if ve.value  ==  unsafe { nil }  {
return 0.0 
}
return ve.value 
}

// StringValue gets the ValueExpression value cast as a str
pub fn (mut ve ValueExpression) string_value() (string, error, ) {mut err:=ve.validate_value_type(expression_value_type.string ,)  
if err  !=  unsafe { nil }  {
return "" ,err 
}
return ve.string_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) string_value_1() (string, ) {if ve.value  ==  unsafe { nil }  {
return "" 
}
return ve.value 
}

// GuidValue gets the ValueExpression value cast as a guid.G
pub fn (mut ve ValueExpression) guid_value() (guid.Guid, error, ) {mut err:=ve.validate_value_type(expression_value_type.guid ,)  
if err  !=  unsafe { nil }  {
return guid.Guid{} ,err 
}
return ve.guid_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) guid_value_1() (guid.Guid, ) {if ve.value  ==  unsafe { nil }  {
return guid.Guid{} 
}
return ve.value 
}

// DateTimeValue gets the ValueExpression value cast as a time.T
pub fn (mut ve ValueExpression) date_time_value() (time.Time, error, ) {mut err:=ve.validate_value_type(expression_value_type.date_time ,)  
if err  !=  unsafe { nil }  {
return time.Time{} ,err 
}
return ve.date_time_value() ,unsafe { nil } 
}

fn (mut ve ValueExpression) date_time_value_1() (time.Time, ) {if ve.value  ==  unsafe { nil }  {
return time.Time{} 
}
return ve.value 
}

// Convert attempts to convert the ValueExpression to the specified targetValueT
pub fn (mut ve ValueExpression) convert(targetValueType_1 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if ve.is_null() {
return null_value(targetValueType_1 ,) ,unsafe { nil } 
}
 match ve.value_type() {expression_value_type.boolean {
return ve.convert_from_boolean(targetValueType_1 ,) 
}
expression_value_type.int32 {
return ve.convert_from_int32(targetValueType_1 ,) 
}
expression_value_type.int64 {
return ve.convert_from_int64(targetValueType_1 ,) 
}
expression_value_type.decimal {
return ve.convert_from_decimal(targetValueType_1 ,) 
}
expression_value_type.double {
return ve.convert_from_double(targetValueType_1 ,) 
}
expression_value_type.string {
return ve.convert_from_string(targetValueType_1 ,) 
}
expression_value_type.guid {
return ve.convert_from_guid(targetValueType_1 ,) 
}
expression_value_type.date_time {
return ve.convert_from_date_time(targetValueType_1 ,) 
}
expression_value_type.undefined {
return null_value(targetValueType_1 ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_boolean(targetValueType_2 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut value_1:=ve.boolean_value_as_int()  
 match targetValueType_2 {expression_value_type.boolean {
return new_value_expression_1(targetValueType_2 ,value_1  !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression_1(targetValueType_2 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression_1(targetValueType_2 ,i64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression_1(targetValueType_2 ,decimal.new_from_int(i64(value_1 ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression_1(targetValueType_2 ,f64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_2 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
return unsafe { nil } ,errors.new("cannot convert \"Boolean\" to \""  +  targetValueType_2.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_int32(targetValueType_3 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut value_1:=ve.int32_value()  
 match targetValueType_3 {expression_value_type.boolean {
return new_value_expression_1(targetValueType_3 ,value_1  !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression_1(targetValueType_3 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression_1(targetValueType_3 ,i64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression_1(targetValueType_3 ,decimal.new_from_int(i64(value_1 ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression_1(targetValueType_3 ,f64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_3 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
return unsafe { nil } ,errors.new("cannot convert \"Int32\" to \""  +  targetValueType_3.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_int64(targetValueType_4 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut value_1:=ve.int64_value()  
 match targetValueType_4 {expression_value_type.boolean {
return new_value_expression_1(targetValueType_4 ,value_1  !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression_1(targetValueType_4 ,i32(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression_1(targetValueType_4 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression_1(targetValueType_4 ,decimal.new_from_int(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression_1(targetValueType_4 ,f64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_4 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
return unsafe { nil } ,errors.new("cannot convert \"Int64\" to \""  +  targetValueType_4.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_decimal(targetValueType_5 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut value_1:=ve.decimal_value()  
 match targetValueType_5 {expression_value_type.boolean {
return new_value_expression_1(targetValueType_5 ,! value_1.equal(decimal.zero ,)  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression_1(targetValueType_5 ,i32(value_1.int_part() ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression_1(targetValueType_5 ,value_1.int_part() ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression_1(targetValueType_5 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.double {
mut f64,_:=value_1.float64()  
return new_value_expression_1(targetValueType_5 ,f64 ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_5 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
return unsafe { nil } ,errors.new("cannot convert \"Decimal\" to \""  +  targetValueType_5.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_double(targetValueType_6 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut value_1:=ve.double_value()  
 match targetValueType_6 {expression_value_type.boolean {
return new_value_expression_1(targetValueType_6 ,value_1  !=  0.0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression_1(targetValueType_6 ,i32(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression_1(targetValueType_6 ,i64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression_1(targetValueType_6 ,decimal.new_from_float(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression_1(targetValueType_6 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_6 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
return unsafe { nil } ,errors.new("cannot convert \"Double\" to \""  +  targetValueType_6.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_string(targetValueType_7 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut value_1:=ve.string_value()  
 match targetValueType_7 {expression_value_type.boolean {
mut target_value,_:=strconv.parse_bool(value_1 ,)  
return new_value_expression_1(targetValueType_7 ,target_value ,) ,unsafe { nil } 
}
expression_value_type.int32 {
mut decimal_value_2,_:=decimal.new_from_string(value_1 ,)  
mut target_value_1:=decimal_value_2.int_part()  
return new_value_expression_1(targetValueType_7 ,i32(target_value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
mut decimal_value_2,_:=decimal.new_from_string(value_1 ,)  
mut target_value_2:=decimal_value_2.int_part()  
return new_value_expression_1(targetValueType_7 ,target_value_2 ,) ,unsafe { nil } 
}
expression_value_type.decimal {
mut target_value_3,_:=decimal.new_from_string(value_1 ,)  
return new_value_expression_1(targetValueType_7 ,target_value_3 ,) ,unsafe { nil } 
}
expression_value_type.double {
mut target_value_4,_:=strconv.parse_float(value_1 ,64 ,)  
return new_value_expression_1(targetValueType_7 ,target_value_4 ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_7 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.guid {
mut target_value_5,_:=guid.parse(value_1 ,)  
return new_value_expression_1(targetValueType_7 ,target_value_5 ,) ,unsafe { nil } 
}
expression_value_type.date_time {
mut target_value_6,_:=dateparse.parse_any(value_1 ,)  
target_value_6=target_value_6.utc()  
return new_value_expression_1(targetValueType_7 ,target_value_6 ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_guid(targetValueType_8 ExpressionValueTypeEnum) (&ValueExpression, error, ) { match targetValueType_8 {expression_value_type.string {
return new_value_expression_1(targetValueType_8 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression_1(targetValueType_8 ,ve.guid_value() ,) ,unsafe { nil } 
}
expression_value_type.boolean {
fallthrough 
}
expression_value_type.int32 {
fallthrough 
}
expression_value_type.int64 {
fallthrough 
}
expression_value_type.decimal {
fallthrough 
}
expression_value_type.double {
fallthrough 
}
expression_value_type.date_time {
return unsafe { nil } ,errors.new("cannot convert \"Guid\" to \""  +  targetValueType_8.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut ve ValueExpression) convert_from_date_time(targetValueType_9 ExpressionValueTypeEnum) (&ValueExpression, error, ) {mut result:=ve.date_time_value()  
mut value_1:=result.unix()  
 match targetValueType_9 {expression_value_type.boolean {
return new_value_expression_1(targetValueType_9 ,value_1  !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression_1(targetValueType_9 ,i32(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression_1(targetValueType_9 ,value_1 ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression_1(targetValueType_9 ,decimal.new_from_int(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression_1(targetValueType_9 ,f64(value_1 ,) ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression_1(targetValueType_9 ,ve.string() ,) ,unsafe { nil } 
}
expression_value_type.date_time {
return new_value_expression_1(targetValueType_9 ,result ,) ,unsafe { nil } 
}
expression_value_type.guid {
return unsafe { nil } ,errors.new("cannot convert \"DateTime\" to \""  +  targetValueType_9.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}
