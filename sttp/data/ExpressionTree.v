module data
import math
import regex
import strconv
import strings
import time
import github.com.araddon.dateparse
import github.com.shopspring.decimal
import github.com.sttp.goapi.sttp.guid
const (
whitespace=string(" \t\n\v\f\r\x85\xA0" )
int_size=int(@unsafe.@sizeof(uint(0 ,) ,)  *  8  ,) 
)
struct ExpressionTree {
mut:
current_row &DataRow 
table_name string 
top_limit int 
order_by_terms []&OrderByTerm 
root Expression 
}
// NewExpressionTree creates a new expression t
pub fn new_expression_tree() (&ExpressionTree, ) {return & ExpressionTree{
top_limit:- 1   }  
}

// Select returns the rows matching the the ExpressionTree. The expression tree result type is expe
pub fn (mut et ExpressionTree) @select(table &DataTable) ([]&DataRow, error, ) {return et.select_where(table ,fn (resultExpression &ValueExpression) (bool, error, ) {if resultExpression.value_type()  !=  expression_value_type.boolean  {
return false ,errors.new("cannot execute select operation, final expression tree evaluation did not result in a boolean value, result data type is \""  +  resultExpression.value_type.string()   +  "\""  ,) 
}
return resultExpression.boolean_value() ,unsafe { nil } 
}
 ,true ,true ,) 
}

// SelectWhere returns each table row evaluated from the ExpressionTree that matches the specified predicate express
pub fn (mut et ExpressionTree) select_where(table_1 &DataTable, predicate fn ( &ValueExpression) (bool, error, ) , applyLimit bool, applySort bool) ([]&DataRow, error, ) {if table_1  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("cannot execute select operation, table parameter is nil" ,) 
}
mut matched_rows:=[]*DataRow{len: 0 }  
mut row:=&DataRow{} 
mut result_expression:=&ValueExpression{} 
mut result:=false 
mut err:=error{} 
for i:=0  ;i  <  table_1.row_count()  ;i++ {
if applyLimit  &&  et.top_limit  >  - 1     &&  matched_rows .len  >=  et.top_limit   {
break 
}
row=table_1.row(i ,) 
if row  ==  unsafe { nil }  {
continue 
}
result_expression,err=et.evaluate(row ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
result,err=predicate(result_expression ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
if result {
matched_rows <<row   
}
}
if applySort  &&  matched_rows .len  >  0    &&  et.order_by_terms .len  >  0   {
sort.slice(matched_rows ,fn (i_1 int) (bool, ) {mut left_matched_row:=matched_rows[i_1 ]  
mut right_matched_row:=matched_rows[j ]  
for _, order_by_term in  et.order_by_terms  {
mut left_row,right_row:=&DataRow{},&DataRow{} 
if order_by_term.ascending {
left_row=left_matched_row  
right_row=right_matched_row  
}else {
left_row=right_matched_row  
right_row=left_matched_row  
}
mut result_1,_:=compare_data_row_columns(left_row ,right_row ,order_by_term.column.index() ,order_by_term.exact_match ,)  
if result_1  <  0  {
return true 
}
if result_1  >  0  {
return false 
}
}
return false 
}
 ,)
}
return matched_rows ,unsafe { nil } 
}

// Evaluate traverses the the ExpressionTree for the provided dataRow to produce a ValueExpress
pub fn (mut et ExpressionTree) evaluate(dataRow &DataRow) (&ValueExpression, error, ) {et.current_row=dataRow  
return et.evaluate(et.root ,) 
}

fn (mut et ExpressionTree) evaluate_1(expression Expression) (&ValueExpression, error, ) {return et.evaluate_as(expression ,expression_value_type.boolean ,) 
}

fn (mut et ExpressionTree) evaluate_as(expression_1 Expression, targetValueType ExpressionValueTypeEnum) (&ValueExpression, error, ) {if expression_1  ==  unsafe { nil }  {
return null_value(targetValueType ,) ,unsafe { nil } 
}
 match expression_1.@type() {expression_type.value {
mut value_expression:=expression_1  
if value_expression.value_type()  ==  expression_value_type.undefined  {
return null_value(targetValueType ,) ,unsafe { nil } 
}
return value_expression ,unsafe { nil } 
}
expression_type.unary {
return et.evaluate_unary(expression_1 ,) 
}
expression_type.column {
return et.evaluate_column(expression_1 ,) 
}
expression_type.in_list {
return et.evaluate_in_list(expression_1 ,) 
}
expression_type.function {
return et.evaluate_function(expression_1 ,) 
}
expression_type.operator {
return et.evaluate_operator(expression_1 ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) evaluate_unary(expression_2 Expression) (&ValueExpression, error, ) {mut unary_expression:=expression_2  
mut err:=error{} 
mut unary_value:=&ValueExpression{} 
unary_value,err=et.evaluate(unary_expression.value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating unary expression value: "  +  err.error()  ,) 
}
mut unary_value_type:=unary_value.value_type()  
if unary_value.is_null() {
return null_value(unary_value_type ,) ,unsafe { nil } 
}
 match unary_value_type {expression_value_type.boolean {
return unary_expression.unary_boolean(unary_value.boolean_value() ,) 
}
expression_value_type.int32 {
return unary_expression.unary_int32(unary_value.int32_value() ,) 
}
expression_value_type.int64 {
return unary_expression.unary_int64(unary_value.int64_value() ,) 
}
expression_value_type.decimal {
return unary_expression.unary_decimal(unary_value.decimal_value() ,) 
}
expression_value_type.double {
return unary_expression.unary_double(unary_value.double_value() ,) 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply unary \""  +  unary_expression.unary_type.string()   +  "\" operator to \""   +  unary_value_type.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

//gocyclo:ig
fn (mut et ExpressionTree) evaluate_column(expression_3 Expression) (&ValueExpression, error, ) {if et.current_row  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating column expression, current data row is not defined" ,) 
}
mut column_expression:=expression_3  
mut column:=&DataColumn{} 
mut err:=error{} 
column=column_expression.data_column() 
if column  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating column expression, data column reference is not defined" ,) 
}
mut column_index:=column.index()  
mut value_type:=ExpressionValueTypeEnum{} 
mut value:=T{} 
mut is_null:=false 
 match column.@type() {data_type.string {
value_type=expression_value_type.string  
value,is_null,err=et.current_row.string_value(column_index ,)  
}
data_type.boolean {
value_type=expression_value_type.boolean  
value,is_null,err=et.current_row.boolean_value(column_index ,)  
}
data_type.date_time {
value_type=expression_value_type.date_time  
value,is_null,err=et.current_row.date_time_value(column_index ,)  
}
data_type.single {
mut f32:=0.0 
value_type=expression_value_type.double  
f32,is_null,err=et.current_row.single_value(column_index ,)  
value=f64(f32 ,)  
}
data_type.double {
value_type=expression_value_type.double  
value,is_null,err=et.current_row.double_value(column_index ,)  
}
data_type.decimal {
value_type=expression_value_type.decimal  
value,is_null,err=et.current_row.decimal_value(column_index ,)  
}
data_type.guid {
value_type=expression_value_type.guid  
value,is_null,err=et.current_row.guid_value(column_index ,)  
}
data_type.int8 {
mut i8:=0 
value_type=expression_value_type.int32  
i8,is_null,err=et.current_row.int8_value(column_index ,)  
value=i32(i8 ,)  
}
data_type.int16 {
mut i16:=0 
value_type=expression_value_type.int32  
i16,is_null,err=et.current_row.int16_value(column_index ,)  
value=i32(i16 ,)  
}
data_type.int32 {
value_type=expression_value_type.int32  
value,is_null,err=et.current_row.int32_value(column_index ,)  
}
data_type.int64 {
value_type=expression_value_type.int64  
value,is_null,err=et.current_row.int64_value(column_index ,)  
}
data_type.uint8 {
mut ui8:=0 
value_type=expression_value_type.int32  
ui8,is_null,err=et.current_row.uint8_value(column_index ,)  
value=i32(ui8 ,)  
}
data_type.uint16 {
mut ui16:=0 
value_type=expression_value_type.int32  
ui16,is_null,err=et.current_row.uint16_value(column_index ,)  
value=i32(ui16 ,)  
}
data_type.uint32 {
mut ui32:=0 
value_type=expression_value_type.int64  
ui32,is_null,err=et.current_row.uint32_value(column_index ,)  
value=i64(ui32 ,)  
}
data_type.uint64 {
mut ui64:=0 
ui64,is_null,err=et.current_row.uint64_value(column_index ,)  
if ui64  >  math.max_int64  {
value_type=expression_value_type.double  
value=f64(ui64 ,)  
}else {
value_type=expression_value_type.int64  
value=i64(ui64 ,)  
}
}
else{
return unsafe { nil } ,errors.new("unexpected column data type encountered" ,) 
}
}
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while getting column \""  +  column.name()   +  "\" "   +  column.@type.string()   +  " value for current row: "   +  err.error()  ,) 
}
if is_null {
return null_value(value_type ,) ,unsafe { nil } 
}
return new_value_expression(value_type ,value ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) evaluate_in_list(expression_4 Expression) (&ValueExpression, error, ) {mut in_list_expression:=expression_4  
mut in_list_value:=&ValueExpression{} 
mut err:=error{} 
in_list_value,err=et.evaluate(in_list_expression.value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IN\" expression source value: "  +  err.error()  ,) 
}
if in_list_value.is_null() {
return null_value(in_list_value.value_type() ,) ,unsafe { nil } 
}
mut has_not_key_word:=in_list_expression.has_not_keyword()  
mut exact_match:=in_list_expression.extact_match()  
mut arguments:=in_list_expression.arguments()  
mut argument_value,result:=&ValueExpression{},&ValueExpression{} 
mut value_type:=ExpressionValueTypeEnum{} 
for i:=0  ;i  <  arguments .len  ;i++ {
argument_value,err=et.evaluate(arguments[i ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IN\" expression argument "  +  strconv.itoa(i ,)   +  ": "   +  err.error()  ,) 
}
value_type,err=expression_operator_type.equal.derive_comparison_operation_value_type(in_list_value.value_type() ,argument_value.value_type() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while deriving \"IN\" expresssion equality comparison operation value type: "  +  err.error()  ,) 
}
result,err=et.equal_op(in_list_value ,argument_value ,value_type ,exact_match ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while comparing \"IN\" expresssion source value to argument "  +  strconv.itoa(i ,)   +  " for equality: "   +  err.error()  ,) 
}
if result.boolean_value() {
if has_not_key_word {
return false ,unsafe { nil } 
}
return true ,unsafe { nil } 
}
}
if has_not_key_word {
return true ,unsafe { nil } 
}
return false ,unsafe { nil } 
}

//gocyclo:ig
fn (mut et ExpressionTree) evaluate_function(expression_5 Expression) (&ValueExpression, error, ) {mut function_expression:=expression_5  
mut arguments:=function_expression.arguments()  
 match function_expression.function_type() {expression_function_type.abs {
return et.evaluate_abs(arguments ,) 
}
expression_function_type.ceiling {
return et.evaluate_ceiling(arguments ,) 
}
expression_function_type.coalesce {
return et.evaluate_coalesce(arguments ,) 
}
expression_function_type.convert {
return et.evaluate_convert(arguments ,) 
}
expression_function_type.contains {
return et.evaluate_contains(arguments ,) 
}
expression_function_type.date_add {
return et.evaluate_date_add(arguments ,) 
}
expression_function_type.date_diff {
return et.evaluate_date_diff(arguments ,) 
}
expression_function_type.date_part {
return et.evaluate_date_part(arguments ,) 
}
expression_function_type.ends_with {
return et.evaluate_ends_with(arguments ,) 
}
expression_function_type.floor {
return et.evaluate_floor(arguments ,) 
}
expression_function_type.iif {
return et.evaluate_iif(arguments ,) 
}
expression_function_type.index_of {
return et.evaluate_index_of(arguments ,) 
}
expression_function_type.is_date {
return et.evaluate_is_date(arguments ,) 
}
expression_function_type.is_integer {
return et.evaluate_is_integer(arguments ,) 
}
expression_function_type.is_guid {
return et.evaluate_is_guid(arguments ,) 
}
expression_function_type.is_null {
return et.evaluate_is_null(arguments ,) 
}
expression_function_type.is_numeric {
return et.evaluate_is_numeric(arguments ,) 
}
expression_function_type.last_index_of {
return et.evaluate_last_index_of(arguments ,) 
}
expression_function_type.len {
return et.evaluate_len(arguments ,) 
}
expression_function_type.lower {
return et.evaluate_lower(arguments ,) 
}
expression_function_type.max_of {
return et.evaluate_max_of(arguments ,) 
}
expression_function_type.min_of {
return et.evaluate_min_of(arguments ,) 
}
expression_function_type.nth_index_of {
return et.evaluate_nth_index_of(arguments ,) 
}
expression_function_type.now {
return et.evaluate_now(arguments ,) 
}
expression_function_type.power {
return et.evaluate_power(arguments ,) 
}
expression_function_type.reg_ex_match {
return et.evaluate_reg_ex_match(arguments ,) 
}
expression_function_type.reg_ex_val {
return et.evaluate_reg_ex_val(arguments ,) 
}
expression_function_type.replace {
return et.evaluate_replace(arguments ,) 
}
expression_function_type.reverse {
return et.evaluate_reverse(arguments ,) 
}
expression_function_type.round {
return et.evaluate_round(arguments ,) 
}
expression_function_type.split {
return et.evaluate_split(arguments ,) 
}
expression_function_type.sqrt {
return et.evaluate_sqrt(arguments ,) 
}
expression_function_type.starts_with {
return et.evaluate_starts_with(arguments ,) 
}
expression_function_type.str_count {
return et.evaluate_str_count(arguments ,) 
}
expression_function_type.str_cmp {
return et.evaluate_str_cmp(arguments ,) 
}
expression_function_type.sub_str {
return et.evaluate_sub_str(arguments ,) 
}
expression_function_type.trim {
return et.evaluate_trim(arguments ,) 
}
expression_function_type.trim_left {
return et.evaluate_trim_left(arguments ,) 
}
expression_function_type.trim_right {
return et.evaluate_trim_right(arguments ,) 
}
expression_function_type.upper {
return et.evaluate_upper(arguments ,) 
}
expression_function_type.utc_now {
return et.evaluate_utc_now(arguments ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected function type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) evaluate_abs(arguments []Expression) (&ValueExpression, error, ) {if arguments .len  !=  1  {
return unsafe { nil } ,errors.new("\"Abs\" function expects 1 argument, received "  +  strconv.itoa(arguments .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments[0 ] ,expression_value_type.double ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Abs\" function source value, first argument: "  +  err.error()  ,) 
}
return et.abs(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_ceiling(arguments_1 []Expression) (&ValueExpression, error, ) {if arguments_1 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Ceiling\" function expects 1 argument, received "  +  strconv.itoa(arguments_1 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_1[0 ] ,expression_value_type.double ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Ceiling\" function source value, first argument: "  +  err.error()  ,) 
}
return et.ceiling(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_coalesce(arguments_2 []Expression) (&ValueExpression, error, ) {if arguments_2 .len  <  2  {
return unsafe { nil } ,errors.new("\"Coalesce\" function expects at least 2 arguments, received "  +  strconv.itoa(arguments_2 .len ,)  ,) 
}
return et.coalesce(arguments_2 ,) 
}

fn (mut et ExpressionTree) evaluate_convert(arguments_3 []Expression) (&ValueExpression, error, ) {if arguments_3 .len  !=  2  {
return unsafe { nil } ,errors.new("\"Convert\" function expects 2 arguments, received "  +  strconv.itoa(arguments_3 .len ,)  ,) 
}
mut source_value,target_type:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate(arguments_3[0 ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Convert\" function source value, first argument: "  +  err.error()  ,) 
}
target_type,err=et.evaluate_as(arguments_3[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Convert\" function target type, second argument: "  +  err.error()  ,) 
}
return et.convert(source_value ,target_type ,) 
}

fn (mut et ExpressionTree) evaluate_contains(arguments_4 []Expression) (&ValueExpression, error, ) {if arguments_4 .len  <  2   ||  arguments_4 .len  >  3   {
return unsafe { nil } ,errors.new("\"Contains\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_4 .len ,)  ,) 
}
mut source_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_4[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Contains\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_4[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Contains\" function test value, second argument: "  +  err.error()  ,) 
}
if arguments_4 .len  ==  2  {
return et.contains(source_value ,test_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_4[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Contains\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.contains(source_value ,test_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_date_add(arguments_5 []Expression) (&ValueExpression, error, ) {if arguments_5 .len  !=  3  {
return unsafe { nil } ,errors.new("\"DateAdd\" function expects 3 arguments, received "  +  strconv.itoa(arguments_5 .len ,)  ,) 
}
mut source_value,add_value,interval_type:=&ValueExpression{},&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_5[0 ] ,expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DateAdd\" function source value, first argument: "  +  err.error()  ,) 
}
add_value,err=et.evaluate_as(arguments_5[1 ] ,expression_value_type.int32 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DateAdd\" function add value, second argument: "  +  err.error()  ,) 
}
interval_type,err=et.evaluate_as(arguments_5[2 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DateAdd\" function interval type, third argument: "  +  err.error()  ,) 
}
return et.date_add(source_value ,add_value ,interval_type ,) 
}

fn (mut et ExpressionTree) evaluate_date_diff(arguments_6 []Expression) (&ValueExpression, error, ) {if arguments_6 .len  !=  3  {
return unsafe { nil } ,errors.new("\"DateDiff\" function expects 3 arguments, received "  +  strconv.itoa(arguments_6 .len ,)  ,) 
}
mut left_value,right_value,interval_type:=&ValueExpression{},&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
left_value,err=et.evaluate_as(arguments_6[0 ] ,expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DateDiff\" function left value, first argument: "  +  err.error()  ,) 
}
right_value,err=et.evaluate_as(arguments_6[1 ] ,expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DateDiff\" function right value, second argument: "  +  err.error()  ,) 
}
interval_type,err=et.evaluate_as(arguments_6[2 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DateDiff\" function interval type, third argument: "  +  err.error()  ,) 
}
return et.date_diff(left_value ,right_value ,interval_type ,) 
}

fn (mut et ExpressionTree) evaluate_date_part(arguments_7 []Expression) (&ValueExpression, error, ) {if arguments_7 .len  !=  2  {
return unsafe { nil } ,errors.new("\"DatePart\" function expects 2 arguments, received "  +  strconv.itoa(arguments_7 .len ,)  ,) 
}
mut source_value,interval_type:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_7[0 ] ,expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DatePart\" function source value, first argument: "  +  err.error()  ,) 
}
interval_type,err=et.evaluate_as(arguments_7[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"DatePart\" function interval type, second argument: "  +  err.error()  ,) 
}
return et.date_part(source_value ,interval_type ,) 
}

fn (mut et ExpressionTree) evaluate_ends_with(arguments_8 []Expression) (&ValueExpression, error, ) {if arguments_8 .len  <  2   ||  arguments_8 .len  >  3   {
return unsafe { nil } ,errors.new("\"EndsWith\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_8 .len ,)  ,) 
}
mut source_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_8[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"EndsWith\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_8[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"EndsWith\" function test value, second argument: "  +  err.error()  ,) 
}
if arguments_8 .len  ==  2  {
return et.ends_with(source_value ,test_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_8[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"EndsWith\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.ends_with(source_value ,test_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_floor(arguments_9 []Expression) (&ValueExpression, error, ) {if arguments_9 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Floor\" function expects 1 argument, received "  +  strconv.itoa(arguments_9 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_9[0 ] ,expression_value_type.double ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Floor\" function source value, first argument: "  +  err.error()  ,) 
}
return et.floor(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_iif(arguments_10 []Expression) (&ValueExpression, error, ) {if arguments_10 .len  !=  3  {
return unsafe { nil } ,errors.new("\"IIf\" function expects 3 arguments, received "  +  strconv.itoa(arguments_10 .len ,)  ,) 
}
mut test_value:=&ValueExpression{} 
mut err:=error{} 
test_value,err=et.evaluate(arguments_10[1 ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IIf\" function test value, first argument: "  +  err.error()  ,) 
}
return et.iif(test_value ,arguments_10[1 ] ,arguments_10[2 ] ,) 
}

fn (mut et ExpressionTree) evaluate_index_of(arguments_11 []Expression) (&ValueExpression, error, ) {if arguments_11 .len  <  2   ||  arguments_11 .len  >  3   {
return unsafe { nil } ,errors.new("\"IndexOf\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_11 .len ,)  ,) 
}
mut source_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_11[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IndexOf\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_11[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IndexOf\" function test value, second argument: "  +  err.error()  ,) 
}
if arguments_11 .len  ==  2  {
return et.index_of(source_value ,test_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_11[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IndexOf\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.index_of(source_value ,test_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_is_date(arguments_12 []Expression) (&ValueExpression, error, ) {if arguments_12 .len  !=  1  {
return unsafe { nil } ,errors.new("\"IsDate\" function expects 1 argument, received "  +  strconv.itoa(arguments_12 .len ,)  ,) 
}
mut test_value:=&ValueExpression{} 
mut err:=error{} 
test_value,err=et.evaluate(arguments_12[0 ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IsDate\" function test value, first argument: "  +  err.error()  ,) 
}
return et.is_date(test_value ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) evaluate_is_integer(arguments_13 []Expression) (&ValueExpression, error, ) {if arguments_13 .len  !=  1  {
return unsafe { nil } ,errors.new("\"IsInteger\" function expects 1 argument, received "  +  strconv.itoa(arguments_13 .len ,)  ,) 
}
mut test_value:=&ValueExpression{} 
mut err:=error{} 
test_value,err=et.evaluate(arguments_13[0 ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IsInteger\" function test value, first argument: "  +  err.error()  ,) 
}
return et.is_integer(test_value ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) evaluate_is_guid(arguments_14 []Expression) (&ValueExpression, error, ) {if arguments_14 .len  !=  1  {
return unsafe { nil } ,errors.new("\"IsGuid\" function expects 1 argument, received "  +  strconv.itoa(arguments_14 .len ,)  ,) 
}
mut test_value:=&ValueExpression{} 
mut err:=error{} 
test_value,err=et.evaluate(arguments_14[0 ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IsGuid\" function test value, first argument: "  +  err.error()  ,) 
}
return et.is_guid(test_value ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) evaluate_is_null(arguments_15 []Expression) (&ValueExpression, error, ) {if arguments_15 .len  !=  2  {
return unsafe { nil } ,errors.new("\"IsNull\" function expects 2 arguments, received "  +  strconv.itoa(arguments_15 .len ,)  ,) 
}
mut test_value,default_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
test_value,err=et.evaluate_as(arguments_15[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IsNull\" function test value, first argument: "  +  err.error()  ,) 
}
default_value,err=et.evaluate_as(arguments_15[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IsNull\" function default value, second argument: "  +  err.error()  ,) 
}
return et.is_null(test_value ,default_value ,) 
}

fn (mut et ExpressionTree) evaluate_is_numeric(arguments_16 []Expression) (&ValueExpression, error, ) {if arguments_16 .len  !=  1  {
return unsafe { nil } ,errors.new("\"IsNumeric\" function expects 1 argument, received "  +  strconv.itoa(arguments_16 .len ,)  ,) 
}
mut test_value:=&ValueExpression{} 
mut err:=error{} 
test_value,err=et.evaluate(arguments_16[0 ] ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IsNumeric\" function test value, first argument: "  +  err.error()  ,) 
}
return et.is_numeric(test_value ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) evaluate_last_index_of(arguments_17 []Expression) (&ValueExpression, error, ) {if arguments_17 .len  <  2   ||  arguments_17 .len  >  3   {
return unsafe { nil } ,errors.new("\"LastIndexOf\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_17 .len ,)  ,) 
}
mut source_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_17[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"LastIndexOf\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_17[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"LastIndexOf\" function test value, second argument: "  +  err.error()  ,) 
}
if arguments_17 .len  ==  2  {
return et.last_index_of(source_value ,test_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_17[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"LastIndexOf\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.last_index_of(source_value ,test_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_len(arguments_18 []Expression) (&ValueExpression, error, ) {if arguments_18 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Len\" function expects 1 argument, received "  +  strconv.itoa(arguments_18 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_18[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Len\" function source value, first argument: "  +  err.error()  ,) 
}
return et.len(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_lower(arguments_19 []Expression) (&ValueExpression, error, ) {if arguments_19 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Lower\" function expects 1 argument, received "  +  strconv.itoa(arguments_19 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_19[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Lower\" function source value, first argument: "  +  err.error()  ,) 
}
return et.lower(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_max_of(arguments_20 []Expression) (&ValueExpression, error, ) {if arguments_20 .len  <  2  {
return unsafe { nil } ,errors.new("\"MaxOf\" function expects at least 2 arguments, received "  +  strconv.itoa(arguments_20 .len ,)  ,) 
}
return et.max_of(arguments_20 ,) 
}

fn (mut et ExpressionTree) evaluate_min_of(arguments_21 []Expression) (&ValueExpression, error, ) {if arguments_21 .len  <  2  {
return unsafe { nil } ,errors.new("\"MinOf\" function expects at least 2 arguments, received "  +  strconv.itoa(arguments_21 .len ,)  ,) 
}
return et.min_of(arguments_21 ,) 
}

fn (mut et ExpressionTree) evaluate_nth_index_of(arguments_22 []Expression) (&ValueExpression, error, ) {if arguments_22 .len  <  3   ||  arguments_22 .len  >  4   {
return unsafe { nil } ,errors.new("\"NthIndexOf\" function expects 3 or 4 arguments, received "  +  strconv.itoa(arguments_22 .len ,)  ,) 
}
mut source_value,test_value,index_value:=&ValueExpression{},&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_22[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"NthIndexOf\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_22[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"NthIndexOf\" function test value, second argument: "  +  err.error()  ,) 
}
index_value,err=et.evaluate_as(arguments_22[2 ] ,expression_value_type.int32 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"NthIndexOf\" function index value, third argument: "  +  err.error()  ,) 
}
if arguments_22 .len  ==  3  {
return et.nth_index_of(source_value ,test_value ,index_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_22[3 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"NthIndexOf\" function optional ignore case value, fourth argument: "  +  err.error()  ,) 
}
return et.nth_index_of(source_value ,test_value ,index_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_now(arguments_23 []Expression) (&ValueExpression, error, ) {if arguments_23 .len  >  0  {
return unsafe { nil } ,errors.new("\"Now\" function expects 0 arguments, received "  +  strconv.itoa(arguments_23 .len ,)  ,) 
}
return et.now() 
}

fn (mut et ExpressionTree) evaluate_power(arguments_24 []Expression) (&ValueExpression, error, ) {if arguments_24 .len  !=  2  {
return unsafe { nil } ,errors.new("\"Power\" function expects 2 arguments, received "  +  strconv.itoa(arguments_24 .len ,)  ,) 
}
mut source_value,exponent_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_24[0 ] ,expression_value_type.double ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Power\" function source value, first argument: "  +  err.error()  ,) 
}
exponent_value,err=et.evaluate_as(arguments_24[1 ] ,expression_value_type.int32 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Power\" function exponent value, second argument: "  +  err.error()  ,) 
}
return et.power(source_value ,exponent_value ,) 
}

fn (mut et ExpressionTree) evaluate_reg_ex_match(arguments_25 []Expression) (&ValueExpression, error, ) {if arguments_25 .len  !=  2  {
return unsafe { nil } ,errors.new("\"RegExMatch\" function expects 2 arguments, received "  +  strconv.itoa(arguments_25 .len ,)  ,) 
}
mut regex_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
regex_value,err=et.evaluate_as(arguments_25[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"RegExMatch\" function expression value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_25[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"RegExMatch\" function test value, second argument: "  +  err.error()  ,) 
}
return et.reg_ex_match(regex_value ,test_value ,) 
}

fn (mut et ExpressionTree) evaluate_reg_ex_val(arguments_26 []Expression) (&ValueExpression, error, ) {if arguments_26 .len  !=  2  {
return unsafe { nil } ,errors.new("\"RegExVal\" function expects 2 arguments, received "  +  strconv.itoa(arguments_26 .len ,)  ,) 
}
mut regex_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
regex_value,err=et.evaluate_as(arguments_26[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"RegExVal\" function expression value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_26[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"RegExVal\" function test value, second argument: "  +  err.error()  ,) 
}
return et.reg_ex_val(regex_value ,test_value ,) 
}

fn (mut et ExpressionTree) evaluate_replace(arguments_27 []Expression) (&ValueExpression, error, ) {if arguments_27 .len  <  3   ||  arguments_27 .len  >  4   {
return unsafe { nil } ,errors.new("\"Replace\" function expects 3 or 4 arguments, received "  +  strconv.itoa(arguments_27 .len ,)  ,) 
}
mut source_value,test_value,replace_value:=&ValueExpression{},&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_27[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Replace\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_27[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Replace\" function test value, second argument: "  +  err.error()  ,) 
}
replace_value,err=et.evaluate_as(arguments_27[2 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Replace\" function replace value, third argument: "  +  err.error()  ,) 
}
if arguments_27 .len  ==  3  {
return et.replace(source_value ,test_value ,replace_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_27[3 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Replace\" function optional ignore case value, fourth argument: "  +  err.error()  ,) 
}
return et.replace(source_value ,test_value ,replace_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_reverse(arguments_28 []Expression) (&ValueExpression, error, ) {if arguments_28 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Reverse\" function expects 1 argument, received "  +  strconv.itoa(arguments_28 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_28[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Reverse\" function source value, first argument: "  +  err.error()  ,) 
}
return et.reverse(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_round(arguments_29 []Expression) (&ValueExpression, error, ) {if arguments_29 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Round\" function expects 1 argument, received "  +  strconv.itoa(arguments_29 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_29[0 ] ,expression_value_type.double ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Round\" function source value, first argument: "  +  err.error()  ,) 
}
return et.round(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_split(arguments_30 []Expression) (&ValueExpression, error, ) {if arguments_30 .len  <  3   ||  arguments_30 .len  >  4   {
return unsafe { nil } ,errors.new("\"Split\" function expects 3 or 4 arguments, received "  +  strconv.itoa(arguments_30 .len ,)  ,) 
}
mut source_value,delimeter_value,index_value:=&ValueExpression{},&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_30[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Split\" function source value, first argument: "  +  err.error()  ,) 
}
delimeter_value,err=et.evaluate_as(arguments_30[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Split\" function delimiter value, second argument: "  +  err.error()  ,) 
}
index_value,err=et.evaluate_as(arguments_30[2 ] ,expression_value_type.int32 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Split\" function index value, third argument: "  +  err.error()  ,) 
}
if arguments_30 .len  ==  3  {
return et.split(source_value ,delimeter_value ,index_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_30[3 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Split\" function optional ignore case value, fourth argument: "  +  err.error()  ,) 
}
return et.split(source_value ,delimeter_value ,index_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_sqrt(arguments_31 []Expression) (&ValueExpression, error, ) {if arguments_31 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Sqrt\" function expects 1 argument, received "  +  strconv.itoa(arguments_31 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_31[0 ] ,expression_value_type.double ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Sqrt\" function source value, first argument: "  +  err.error()  ,) 
}
return et.sqrt(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_starts_with(arguments_32 []Expression) (&ValueExpression, error, ) {if arguments_32 .len  <  2   ||  arguments_32 .len  >  3   {
return unsafe { nil } ,errors.new("\"StartsWith\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_32 .len ,)  ,) 
}
mut source_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_32[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StartsWith\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_32[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StartsWith\" function test value, second argument: "  +  err.error()  ,) 
}
if arguments_32 .len  ==  2  {
return et.starts_with(source_value ,test_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_32[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StartsWith\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.starts_with(source_value ,test_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_str_count(arguments_33 []Expression) (&ValueExpression, error, ) {if arguments_33 .len  <  2   ||  arguments_33 .len  >  3   {
return unsafe { nil } ,errors.new("\"StrCount\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_33 .len ,)  ,) 
}
mut source_value,test_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_33[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StrCount\" function source value, first argument: "  +  err.error()  ,) 
}
test_value,err=et.evaluate_as(arguments_33[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StrCount\" function test value, second argument: "  +  err.error()  ,) 
}
if arguments_33 .len  ==  2  {
return et.str_count(source_value ,test_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_33[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StrCount\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.str_count(source_value ,test_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_str_cmp(arguments_34 []Expression) (&ValueExpression, error, ) {if arguments_34 .len  <  2   ||  arguments_34 .len  >  3   {
return unsafe { nil } ,errors.new("\"StrCmp\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_34 .len ,)  ,) 
}
mut left_value,right_value:=&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
left_value,err=et.evaluate_as(arguments_34[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StrCmp\" function left value, first argument: "  +  err.error()  ,) 
}
right_value,err=et.evaluate_as(arguments_34[1 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StrCmp\" function right value, second argument: "  +  err.error()  ,) 
}
if arguments_34 .len  ==  2  {
return et.str_cmp(left_value ,right_value ,null_value(expression_value_type.boolean ,) ,) 
}
mut ignore_case:=&ValueExpression{} 
ignore_case,err=et.evaluate_as(arguments_34[2 ] ,expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"StrCmp\" function optional ignore case value, third argument: "  +  err.error()  ,) 
}
return et.str_cmp(left_value ,right_value ,ignore_case ,) 
}

fn (mut et ExpressionTree) evaluate_sub_str(arguments_35 []Expression) (&ValueExpression, error, ) {if arguments_35 .len  <  2   ||  arguments_35 .len  >  3   {
return unsafe { nil } ,errors.new("\"SubStr\" function expects 2 or 3 arguments, received "  +  strconv.itoa(arguments_35 .len ,)  ,) 
}
mut source_value,index_value,length_value:=&ValueExpression{},&ValueExpression{},&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_35[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"SubStr\" function source value, first argument: "  +  err.error()  ,) 
}
index_value,err=et.evaluate_as(arguments_35[1 ] ,expression_value_type.int32 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"SubStr\" function index value, second argument: "  +  err.error()  ,) 
}
if arguments_35 .len  ==  2  {
return et.sub_str(source_value ,index_value ,null_value(expression_value_type.int32 ,) ,) 
}
length_value,err=et.evaluate_as(arguments_35[2 ] ,expression_value_type.int32 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"SubStr\" function optional length value, third argument: "  +  err.error()  ,) 
}
return et.sub_str(source_value ,index_value ,length_value ,) 
}

fn (mut et ExpressionTree) evaluate_trim(arguments_36 []Expression) (&ValueExpression, error, ) {if arguments_36 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Trim\" function expects 1 argument, received "  +  strconv.itoa(arguments_36 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_36[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Trim\" function source value, first argument: "  +  err.error()  ,) 
}
return et.trim(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_trim_left(arguments_37 []Expression) (&ValueExpression, error, ) {if arguments_37 .len  !=  1  {
return unsafe { nil } ,errors.new("\"TrimLeft\" function expects 1 argument, received "  +  strconv.itoa(arguments_37 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_37[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"TrimLeft\" function source value, first argument: "  +  err.error()  ,) 
}
return et.trim_left(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_trim_right(arguments_38 []Expression) (&ValueExpression, error, ) {if arguments_38 .len  !=  1  {
return unsafe { nil } ,errors.new("\"TrimRight\" function expects 1 argument, received "  +  strconv.itoa(arguments_38 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_38[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"TrimRight\" function source value, first argument: "  +  err.error()  ,) 
}
return et.trim_right(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_upper(arguments_39 []Expression) (&ValueExpression, error, ) {if arguments_39 .len  !=  1  {
return unsafe { nil } ,errors.new("\"Upper\" function expects 1 argument, received "  +  strconv.itoa(arguments_39 .len ,)  ,) 
}
mut source_value:=&ValueExpression{} 
mut err:=error{} 
source_value,err=et.evaluate_as(arguments_39[0 ] ,expression_value_type.string ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Upper\" function source value, first argument: "  +  err.error()  ,) 
}
return et.upper(source_value ,) 
}

fn (mut et ExpressionTree) evaluate_utc_now(arguments_40 []Expression) (&ValueExpression, error, ) {if arguments_40 .len  >  0  {
return unsafe { nil } ,errors.new("\"UtcNow\" function expects 0 arguments, received "  +  strconv.itoa(arguments_40 .len ,)  ,) 
}
return et.utc_now() 
}

//gocyclo:ig
fn (mut et ExpressionTree) evaluate_operator(expression_6 Expression) (&ValueExpression, error, ) {mut operator_expression:=expression_6  
mut err:=error{} 
mut left_value:=&ValueExpression{} 
left_value,err=et.evaluate(operator_expression.left_value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \""  +  operator_expression.operator_type.string()   +  "\" operator left operand: "   +  err.error()  ,) 
}
mut right_value:=&ValueExpression{} 
right_value,err=et.evaluate(operator_expression.right_value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \""  +  operator_expression.operator_type.string()   +  "\" operator right operand: "   +  err.error()  ,) 
}
mut value_type:=ExpressionValueTypeEnum{} 
value_type,err=operator_expression.operator_type.derive_operation_value_type(left_value.value_type() ,right_value.value_type() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while deriving \""  +  operator_expression.operator_type.string()   +  "\" operator value type: "   +  err.error()  ,) 
}
 match operator_expression.operator_type() {expression_operator_type.multiply {
return et.multiply_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.divide {
return et.divide_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.modulus {
return et.modulus_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.add {
return et.add_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.subtract {
return et.subtract_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.bit_shift_left {
return et.bit_shift_left_op(left_value ,right_value ,) 
}
expression_operator_type.bit_shift_right {
return et.bit_shift_right_op(left_value ,right_value ,) 
}
expression_operator_type.bitwise_and {
return et.bitwise_and_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.bitwise_or {
return et.bitwise_or_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.bitwise_xor {
return et.bitwise_xor_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.less_than {
return et.less_than_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.less_than_or_equal {
return et.less_than_or_equal_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.greater_than {
return et.greater_than_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.greater_than_or_equal {
return et.greater_than_or_equal_op(left_value ,right_value ,value_type ,) 
}
expression_operator_type.equal {
return et.equal_op(left_value ,right_value ,value_type ,false ,) 
}
expression_operator_type.equal_exact_match {
return et.equal_op(left_value ,right_value ,value_type ,true ,) 
}
expression_operator_type.not_equal {
return et.not_equal_op(left_value ,right_value ,value_type ,false ,) 
}
expression_operator_type.not_equal_exact_match {
return et.not_equal_op(left_value ,right_value ,value_type ,true ,) 
}
expression_operator_type.is_null {
return et.is_null_op(left_value ,) ,unsafe { nil } 
}
expression_operator_type.is_not_null {
return et.is_not_null_op(left_value ,) ,unsafe { nil } 
}
expression_operator_type.like {
return et.like_op(left_value ,right_value ,false ,) 
}
expression_operator_type.like_exact_match {
return et.like_op(left_value ,right_value ,true ,) 
}
expression_operator_type.not_like {
return et.not_like_op(left_value ,right_value ,false ,) 
}
expression_operator_type.not_like_exact_match {
return et.not_like_op(left_value ,right_value ,true ,) 
}
expression_operator_type.and {
return et.and_op(left_value ,right_value ,) 
}
expression_operator_type.@or {
return et.or_op(left_value ,right_value ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected operator type encountered" ,) 
}
}
}

fn abs32(value i32) (i32, ) {if value  <  0  {
return - value  
}
return value 
}

fn abs64(value_1 i64) (i64, ) {if value_1  <  0  {
return - value_1  
}
return value_1 
}

fn abs(value_2 int) (int, ) {if value_2  <  0  {
return - value_2  
}
return value_2 
}

fn (mut et ExpressionTree) abs_1(sourceValue &ValueExpression) (&ValueExpression, error, ) {if ! sourceValue.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Abs\" function source value, first argument, must be numeric" ,) 
}
if sourceValue.is_null() {
return null_value(sourceValue.value_type() ,) ,unsafe { nil } 
}
 match sourceValue.value_type() {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,sourceValue.boolean_value() ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,abs32(sourceValue.int32_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,abs64(sourceValue.int64_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,sourceValue.decimal_value.abs() ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.abs(sourceValue.double_value() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) ceiling(sourceValue_1 &ValueExpression) (&ValueExpression, error, ) {if ! sourceValue_1.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Ceiling\" function source value, first argument, must be numeric" ,) 
}
if sourceValue_1.is_null() {
return null_value(sourceValue_1.value_type() ,) ,unsafe { nil } 
}
if sourceValue_1.value_type.is_integer_type() {
return sourceValue_1 ,unsafe { nil } 
}
 match sourceValue_1.value_type() {expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,sourceValue_1.decimal_value.ceil() ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.ceil(sourceValue_1.double_value() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) coalesce(arguments_41 []Expression) (&ValueExpression, error, ) {mut test_value,err:=et.evaluate(arguments_41[0 ] ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Coalesce\" function argument 0: "  +  err.error()  ,) 
}
if ! test_value.is_null()  {
return test_value ,unsafe { nil } 
}
for i:=1  ;i  <  arguments_41 .len  ;i++ {
mut list_value,err_1:=et.evaluate(arguments_41[i ] ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"Coalesce\" function argument "  +  strconv.itoa(i ,)   +  ": "   +  err_1.error()  ,) 
}
if ! list_value.is_null()  {
return list_value ,unsafe { nil } 
}
}
return test_value ,unsafe { nil } 
}

//gocyclo:ig
fn (mut et ExpressionTree) convert(sourceValue_2 &ValueExpression) (&ValueExpression, error, ) {if target_type.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Convert\" function target type, second argument, must be a \"String\"" ,) 
}
if target_type.is_null() {
return unsafe { nil } ,errors.new("\"Convert\" function target type, second argument, is null" ,) 
}
mut target_type_name:=target_type.string_value() .to_upper()  
if strings.has_prefix(target_type_name ,"SYSTEM." ,)  &&  target_type_name .len  >  7   {
target_type_name=target_type_name[7 .. ]  
}
mut target_value_type:=expression_value_type.undefined  
mut found_value_type:=false 
for i:=0  ;i  <  expression_value_type_len()  ;i++ {
mut value_type:=expression_value_type_enum(i ,)  
if target_type_name  ==  value_type.string() .to_upper()  {
target_value_type=value_type  
found_value_type=true  
break 
}
}
if ! found_value_type  {
if target_type_name  ==  "SINGLE"   ||  strings.has_prefix(target_type_name ,"FLOAT" ,)  {
target_value_type=expression_value_type.double  
found_value_type=true  
}else if target_type_name  ==  "BOOL"  {
target_value_type=expression_value_type.boolean  
found_value_type=true  
}else if strings.has_prefix(target_type_name ,"INT" ,)  ||  strings.has_prefix(target_type_name ,"UINT" ,)  {
target_value_type=expression_value_type.int64  
found_value_type=true  
}else if target_type_name  ==  "DATE"   ||  target_type_name  ==  "TIME"   {
target_value_type=expression_value_type.date_time  
found_value_type=true  
}else if target_type_name  ==  "UUID"  {
target_value_type=expression_value_type.guid  
found_value_type=true  
}
}
if ! found_value_type   ||  target_value_type  ==  expression_value_type.undefined   {
mut target,_:=target_type.string_value()  
return unsafe { nil } ,errors.new("specified \"Convert\" function target type \""  +  target   +  "\", second argument, is not supported"  ,) 
}
return sourceValue_2.convert(target_value_type ,) 
}

fn (mut et ExpressionTree) contains(sourceValue_3 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_3.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Contains\" function source value, first argument, must be a \"String\"" ,) 
}
if test_value.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Contains\" function test value, second argument, must be a \"String\"" ,) 
}
if sourceValue_3.is_null() {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
if test_value.is_null() {
return false ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"Contains\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.boolean ,sourceValue_3.string_value() .to_upper() .contains(test_value.string_value() .to_upper() ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.boolean ,sourceValue_3.string_value() .contains(test_value.string_value() ,) ,) ,unsafe { nil } 
}

//gocyclo:ig
fn (mut et ExpressionTree) date_add(sourceValue_4 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_4.value_type()  !=  expression_value_type.date_time   &&  sourceValue_4.value_type()  !=  expression_value_type.string   {
return unsafe { nil } ,errors.new("\"DateAdd\" function source value, first argument, must be a \"DateTime\" or a \"String\"" ,) 
}
if ! add_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("\"DateAdd\" function add value, second argument, must be an integer type" ,) 
}
if interval_type.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"DateAdd\" function interval type, third argument, must be a \"String\"" ,) 
}
if add_value.is_null() {
return unsafe { nil } ,errors.new("\"DateAdd\" function add value, second argument, is null" ,) 
}
if interval_type.is_null() {
return unsafe { nil } ,errors.new("\"DateAdd\" function interval type, third argument, is null" ,) 
}
if sourceValue_4.is_null() {
return sourceValue_4 ,unsafe { nil } 
}
mut err:=error{} 
sourceValue_4,err=sourceValue_4.convert(expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"DateAdd\" function source value, first argument, to \"DateTime\": "  +  err.error()  ,) 
}
mut interval:=TimeIntervalEnum{} 
interval,err=parse_time_interval(interval_type.string_value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while parsing \"DateAdd\" function interval value, third argument, as a valid time interval: "  +  err.error()  ,) 
}
mut value_3:=add_value.integer_value(0 ,)  
 match interval {time_interval.year {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add_date(value_3 ,0 ,0 ,) ,) ,unsafe { nil } 
}
time_interval.month {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add_date(0 ,value_3 ,0 ,) ,) ,unsafe { nil } 
}
time_interval.day_of_year {
fallthrough 
}
time_interval.day {
fallthrough 
}
time_interval.week_day {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add_date(0 ,0 ,value_3 ,) ,) ,unsafe { nil } 
}
time_interval.week {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add_date(0 ,0 ,value_3  *  7  ,) ,) ,unsafe { nil } 
}
time_interval.hour {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add(time.hour  *  time.duration(value_3 ,)  ,) ,) ,unsafe { nil } 
}
time_interval.minute {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add(time.minute  *  time.duration(value_3 ,)  ,) ,) ,unsafe { nil } 
}
time_interval.second {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add(time.second  *  time.duration(value_3 ,)  ,) ,) ,unsafe { nil } 
}
time_interval.millisecond {
return new_value_expression(expression_value_type.date_time ,sourceValue_4.date_time_value.add(time.millisecond  *  time.duration(value_3 ,)  ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected time interval encountered" ,) 
}
}
}

//gocyclo:ig
fn (mut et ExpressionTree) date_diff(leftValue &ValueExpression) (&ValueExpression, error, ) {if leftValue.value_type()  !=  expression_value_type.date_time   &&  leftValue.value_type()  !=  expression_value_type.string   {
return unsafe { nil } ,errors.new("\"DateDiff\" function left value, first argument, must be a \"DateTime\" or a \"String\"" ,) 
}
if right_value.value_type()  !=  expression_value_type.date_time   &&  right_value.value_type()  !=  expression_value_type.string   {
return unsafe { nil } ,errors.new("\"DateDiff\" function right value, second argument, must be a \"DateTime\" or a \"String\"" ,) 
}
if interval_type.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"DateDiff\" function interval type, third argument, must be a \"String\"" ,) 
}
if interval_type.is_null() {
return unsafe { nil } ,errors.new("\"DateDiff\" function interval type, third argument, is null" ,) 
}
if leftValue.is_null()  ||  right_value.is_null()  {
return null_value(expression_value_type.int32 ,) ,unsafe { nil } 
}
mut err:=error{} 
leftValue,err=leftValue.convert(expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"DateDiff\" function left value, first argument, to \"DateTime\": "  +  err.error()  ,) 
}
right_value,err=right_value.convert(expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"DateDiff\" function right value, second argument, to \"DateTime\": "  +  err.error()  ,) 
}
mut interval:=TimeIntervalEnum{} 
interval,err=parse_time_interval(interval_type.string_value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while parsing \"DateDiff\" function interval value, third argument, as a valid time interval: "  +  err.error()  ,) 
}
mut right_date:=right_value.date_time_value()  
mut left_date:=leftValue.date_time_value()  
if interval  <  time_interval.day_of_year  {
 match interval {time_interval.year {
return new_value_expression(expression_value_type.int32 ,i32(right_date.year()  -  left_date.year()  ,) ,) ,unsafe { nil } 
}
time_interval.month {
mut months:=(right_date.year()  -  left_date.year()  )  *  12   
months+=int(right_date.month()  -  left_date.month()  ,)  
return new_value_expression(expression_value_type.int32 ,i32(months ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected time interval encountered" ,) 
}
}
}
mut delta:=right_date.sub(left_date ,)  
 match interval {time_interval.day_of_year {
fallthrough 
}
time_interval.day {
fallthrough 
}
time_interval.week_day {
return new_value_expression(expression_value_type.int32 ,i32(delta.hours()  /  24.0  ,) ,) ,unsafe { nil } 
}
time_interval.week {
return new_value_expression(expression_value_type.int32 ,i32(delta.hours()  /  24.0   /  7.0  ,) ,) ,unsafe { nil } 
}
time_interval.hour {
return new_value_expression(expression_value_type.int32 ,i32(delta.hours() ,) ,) ,unsafe { nil } 
}
time_interval.minute {
return new_value_expression(expression_value_type.int32 ,i32(delta.minutes() ,) ,) ,unsafe { nil } 
}
time_interval.second {
return new_value_expression(expression_value_type.int32 ,i32(delta.seconds() ,) ,) ,unsafe { nil } 
}
time_interval.millisecond {
return new_value_expression(expression_value_type.int32 ,i32(delta.milliseconds() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected time interval encountered" ,) 
}
}
}

//gocyclo:ig
fn (mut et ExpressionTree) date_part(sourceValue_5 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_5.value_type()  !=  expression_value_type.date_time   &&  sourceValue_5.value_type()  !=  expression_value_type.string   {
return unsafe { nil } ,errors.new("\"DatePart\" function source value, first argument, must be a \"DateTime\" or a \"String\"" ,) 
}
if interval_type.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"DatePart\" function interval type, second argument, must be a \"String\"" ,) 
}
if interval_type.is_null() {
return unsafe { nil } ,errors.new("\"DatePart\" function interval type, second argument, is null" ,) 
}
if sourceValue_5.is_null() {
return null_value(expression_value_type.int32 ,) ,unsafe { nil } 
}
mut err:=error{} 
sourceValue_5,err=sourceValue_5.convert(expression_value_type.date_time ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"DatePart\" function source value, first argument, to \"DateTime\": "  +  err.error()  ,) 
}
mut interval:=TimeIntervalEnum{} 
interval,err=parse_time_interval(interval_type.string_value() ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while parsing \"DatePart\" function interval value, second argument, as a valid time interval: "  +  err.error()  ,) 
}
 match interval {time_interval.year {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.year() ,) ,) ,unsafe { nil } 
}
time_interval.month {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.month() ,) ,) ,unsafe { nil } 
}
time_interval.day_of_year {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.year_day() ,) ,) ,unsafe { nil } 
}
time_interval.day {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.day() ,) ,) ,unsafe { nil } 
}
time_interval.week_day {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.weekday()  +  1  ,) ,) ,unsafe { nil } 
}
time_interval.week {
mut _,week:=sourceValue_5.date_time_value.isoweek()  
return new_value_expression(expression_value_type.int32 ,i32(week ,) ,) ,unsafe { nil } 
}
time_interval.hour {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.hour() ,) ,) ,unsafe { nil } 
}
time_interval.minute {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.minute() ,) ,) ,unsafe { nil } 
}
time_interval.second {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.second() ,) ,) ,unsafe { nil } 
}
time_interval.millisecond {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_5.date_time_value.nanosecond()  /  1e6  ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected time interval encountered" ,) 
}
}
}

fn (mut et ExpressionTree) ends_with(sourceValue_6 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_6.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"EndsWith\" function source value, first argument, must be a \"String\"" ,) 
}
if test_value.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"EndsWith\" function test value, second argument, must be a \"String\"" ,) 
}
if sourceValue_6.is_null() {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
if test_value.is_null() {
return false ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"EndsWith\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.boolean ,strings.has_suffix(sourceValue_6.string_value() .to_upper() ,test_value.string_value() .to_upper() ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.boolean ,strings.has_suffix(sourceValue_6.string_value() ,test_value.string_value() ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) floor(sourceValue_7 &ValueExpression) (&ValueExpression, error, ) {if ! sourceValue_7.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Floor\" function source value, first argument, must be numeric" ,) 
}
if sourceValue_7.is_null() {
return null_value(sourceValue_7.value_type() ,) ,unsafe { nil } 
}
if sourceValue_7.value_type.is_integer_type() {
return sourceValue_7 ,unsafe { nil } 
}
 match sourceValue_7.value_type() {expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,sourceValue_7.decimal_value.floor() ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.floor(sourceValue_7.double_value() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) iif(testValue &ValueExpression, leftResultValue Expression) (&ValueExpression, error, ) {if testValue.value_type()  !=  expression_value_type.boolean  {
return unsafe { nil } ,errors.new("\"IIf\" function test value, first argument, must be a \"Boolean\"" ,) 
}
mut result:=&ValueExpression{} 
mut err:=error{} 
if testValue.boolean_value() {
result,err=et.evaluate(leftResultValue ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IIf\" function left result value, second argument: "  +  err.error()  ,) 
}
return result ,unsafe { nil } 
}
result,err=et.evaluate(right_result_value ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"IIf\" function right result value, third argument: "  +  err.error()  ,) 
}
return result ,unsafe { nil } 
}

fn (mut et ExpressionTree) index_of(sourceValue_8 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_8.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"IndexOf\" function source value, first argument, must be a \"String\"" ,) 
}
if testValue.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"IndexOf\" function test value, second argument, must be a \"String\"" ,) 
}
if testValue.is_null() {
return unsafe { nil } ,errors.new("\"IndexOf\" function test value, second argument, is null" ,) 
}
if sourceValue_8.is_null() {
return null_value(expression_value_type.int32 ,) ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"IndexOf\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_8.string_value() .to_upper() .index(testValue.string_value() .to_upper() ,) ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_8.string_value() .index(testValue.string_value() ,) ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) is_date(testValue_1 &ValueExpression) (&ValueExpression, ) {if testValue_1.is_null() {
return false 
}
if testValue_1.value_type()  ==  expression_value_type.date_time  {
return true 
}
if testValue_1.value_type()  ==  expression_value_type.string  {
mut _,err:=dateparse.parse_any(testValue_1.string_value() ,) 
if err  ==  unsafe { nil }  {
return true 
}
}
return false 
}

fn (mut et ExpressionTree) is_integer(testValue_2 &ValueExpression) (&ValueExpression, ) {if testValue_2.is_null() {
return false 
}
if testValue_2.value_type.is_integer_type() {
return true 
}
if testValue_2.value_type()  ==  expression_value_type.string  {
mut _,err:=strconv.parse_int(testValue_2.string_value() ,0 ,64 ,) 
if err  ==  unsafe { nil }  {
return true 
}
}
return false 
}

fn (mut et ExpressionTree) is_guid(testValue_3 &ValueExpression) (&ValueExpression, ) {if testValue_3.is_null() {
return false 
}
if testValue_3.value_type()  ==  expression_value_type.guid  {
return true 
}
if testValue_3.value_type()  ==  expression_value_type.string  {
mut _,err:=guid.parse(testValue_3.string_value() ,) 
if err  ==  unsafe { nil }  {
return true 
}
}
return false 
}

fn (mut et ExpressionTree) is_null_1(testValue_4 &ValueExpression) (&ValueExpression, error, ) {if default_value.is_null() {
return unsafe { nil } ,errors.new("\"IsNull\" default value, second argument, is null" ,) 
}
if testValue_4.is_null() {
return default_value ,unsafe { nil } 
}
return testValue_4 ,unsafe { nil } 
}

fn (mut et ExpressionTree) is_numeric(testValue_5 &ValueExpression) (&ValueExpression, ) {if testValue_5.is_null() {
return false 
}
if testValue_5.value_type.is_numeric_type() {
return true 
}
if testValue_5.value_type()  ==  expression_value_type.string  {
mut _,err:=strconv.parse_float(testValue_5.string_value() ,64 ,) 
if err  ==  unsafe { nil }  {
return true 
}
mut _,err_1:=decimal.new_from_string(testValue_5.string_value() ,) 
if err_1  ==  unsafe { nil }  {
return true 
}
}
return false 
}

fn (mut et ExpressionTree) last_index_of(sourceValue_9 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_9.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"LastIndexOf\" function source value, first argument, must be a \"String\"" ,) 
}
if testValue_5.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"LastIndexOf\" function test value, second argument, must be a \"String\"" ,) 
}
if testValue_5.is_null() {
return unsafe { nil } ,errors.new("\"LastIndexOf\" function test value, second argument, is null" ,) 
}
if sourceValue_9.is_null() {
return null_value(expression_value_type.int32 ,) ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"LastIndexOf\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_9.string_value() .to_upper() .last_index(testValue_5.string_value() .to_upper() ,) ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_9.string_value() .last_index(testValue_5.string_value() ,) ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) len(sourceValue_10 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_10.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Len\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_10.is_null() {
return null_value(expression_value_type.int32 ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_10.string_value() .len ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) lower(sourceValue_11 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_11.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Lower\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_11.is_null() {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,sourceValue_11.string_value() .to_lower() ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) max_of(arguments_42 []Expression) (&ValueExpression, error, ) {mut test_value,err:=et.evaluate(arguments_42[0 ] ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"MaxOf\" function argument 0: "  +  err.error()  ,) 
}
for i:=1  ;i  <  arguments_42 .len  ;i++ {
mut next_value,err_1:=et.evaluate(arguments_42[i ] ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"MaxOf\" function argument "  +  strconv.itoa(i ,)   +  ": "   +  err_1.error()  ,) 
}
mut value_type,err_2:=expression_operator_type.greater_than.derive_comparison_operation_value_type(test_value.value_type() ,next_value.value_type() ,)  
if err_2  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while deriving \"MaxOf\" function greater than comparison operation value type: "  +  err_2.error()  ,) 
}
mut result,err_3:=et.greater_than_op(next_value ,test_value ,value_type ,)  
if err_3  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while executing \">\" comparison operation in \"MaxOf\" function: "  +  err_3.error()  ,) 
}
if result.boolean_value()  ||  (test_value.is_null()  &&  ! next_value.is_null()   )  {
test_value=next_value  
}
}
return test_value ,unsafe { nil } 
}

fn (mut et ExpressionTree) min_of(arguments_43 []Expression) (&ValueExpression, error, ) {mut test_value,err:=et.evaluate(arguments_43[0 ] ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"MinOf\" function argument 0: "  +  err.error()  ,) 
}
for i:=1  ;i  <  arguments_43 .len  ;i++ {
mut next_value,err_1:=et.evaluate(arguments_43[i ] ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while evaluating \"MinOf\" function argument "  +  strconv.itoa(i ,)   +  ": "   +  err_1.error()  ,) 
}
mut value_type,err_2:=expression_operator_type.less_than.derive_comparison_operation_value_type(test_value.value_type() ,next_value.value_type() ,)  
if err_2  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while deriving \"MinOf\" function less than comparison operation value type: "  +  err_2.error()  ,) 
}
mut result,err_3:=et.less_than_op(next_value ,test_value ,value_type ,)  
if err_3  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while executing \"<\" comparison operation in \"MinOf\" function: "  +  err_3.error()  ,) 
}
if result.boolean_value()  ||  (test_value.is_null()  &&  ! next_value.is_null()   )  {
test_value=next_value  
}
}
return test_value ,unsafe { nil } 
}

fn (mut et ExpressionTree) now() (&ValueExpression, error, ) {return new_value_expression(expression_value_type.date_time ,time.now() ,) ,unsafe { nil } 
}

// https://play.golang.org/p/-zlKH7m
fn find_nth_index(source_1 string, index int) (int, ) {mut result:=0 
for i:=0  ;i  <  index  +  1   ;i++ {
mut location:=source_1 .index(test ,)  
if location  ==  - 1   {
result=0  
break 
}
location++
result+=location  
source_1=source_1[location .. ]  
}
return result  -  1  
}

fn (mut et ExpressionTree) nth_index_of(sourceValue_12 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_12.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"NthIndexOf\" function source value, first argument, must be a \"String\"" ,) 
}
if testValue_5.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"NthIndexOf\" function test value, second argument, must be a \"String\"" ,) 
}
if ! index_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("\"NthIndexOf\" function index value, third argument, must be an integer type" ,) 
}
if testValue_5.is_null() {
return unsafe { nil } ,errors.new("\"NthIndexOf\" function test value, second argument, is null" ,) 
}
if index_value.is_null() {
return unsafe { nil } ,errors.new("\"NthIndexOf\" function index value, third argument, is null" ,) 
}
if sourceValue_12.is_null() {
return null_value(expression_value_type.int32 ,) ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"NthIndexOf\" function optional ignore case value, fourth argument, to \"Boolean\": "  +  err.error()  ,) 
}
mut source,test:='','' 
if ignore_case.boolean_value() {
source=sourceValue_12.string_value() .to_upper()  
test=testValue_5.string_value() .to_upper()  
}else {
source=sourceValue_12.string_value()  
test=testValue_5.string_value()  
}
return new_value_expression(expression_value_type.int32 ,i32(find_nth_index(source ,test ,index_value.integer_value(- 1  ,) ,) ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) power(sourceValue_13 &ValueExpression) (&ValueExpression, error, ) {if ! sourceValue_13.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Power\" function source value, first argument, must be numeric" ,) 
}
if ! exponent_value.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Power\" function exponent value, second argument, must be numeric" ,) 
}
if sourceValue_13.is_null()  ||  exponent_value.is_null()  {
return null_value(sourceValue_13.value_type() ,) ,unsafe { nil } 
}
mut value_type,err:=expression_operator_type.multiply.derive_arithmetic_operation_value_type(sourceValue_13.value_type() ,exponent_value.value_type() ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while deriving \"Power\" function multiplicative arithmetic operation value type: "  +  err.error()  ,) 
}
sourceValue_13,err=sourceValue_13.convert(value_type ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"Power\" function source value, first argument, to \""  +  value_type.string()   +  "\": "   +  err.error()  ,) 
}
exponent_value,err=sourceValue_13.convert(value_type ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"Power\" function exponent value, second argument, to \""  +  value_type.string()   +  "\": "   +  err.error()  ,) 
}
 match sourceValue_13.value_type() {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,math.pow(f64(sourceValue_13.boolean_value_as_int() ,) ,f64(exponent_value.boolean_value_as_int() ,) ,)  !=  0.0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(math.pow(f64(sourceValue_13.int32_value() ,) ,f64(exponent_value.int32_value() ,) ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(math.pow(f64(sourceValue_13.int64_value() ,) ,f64(exponent_value.int64_value() ,) ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,sourceValue_13.decimal_value.pow(exponent_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.pow(sourceValue_13.double_value() ,exponent_value.double_value() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) reg_ex_match(regexValue &ValueExpression) (&ValueExpression, error, ) {return et.evaluate_reg_ex("RegExMatch" ,regexValue ,testValue_5 ,false ,) 
}

fn (mut et ExpressionTree) reg_ex_val(regexValue_1 &ValueExpression) (&ValueExpression, error, ) {return et.evaluate_reg_ex("RegExVal" ,regexValue_1 ,testValue_5 ,true ,) 
}

fn (mut et ExpressionTree) evaluate_reg_ex(functionName string, regexValue_2 &ValueExpression, returnMatchedValue bool) (&ValueExpression, error, ) {if regexValue_2.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\""  +  functionName   +  "\" function expression value, first argument, must be a \"String\""  ,) 
}
if testValue_5.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\""  +  functionName   +  "\" function test value, second argument, must be a \"String\""  ,) 
}
if regexValue_2.is_null()  ||  testValue_5.is_null()  {
if returnMatchedValue {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
mut regex,err:=regexp.compile(regexValue_2.string_value() ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while compiling \""  +  functionName   +  "\" function expression value, first argument: "   +  err.error()  ,) 
}
mut test_text:=testValue_5.string_value()  
mut result:=regex.find_string_index(test_text ,)  
if returnMatchedValue {
if result  ==  unsafe { nil }  {
return empty_string ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,test_text[result[0 ] ..result[1 ] ] ,) ,unsafe { nil } 
}
if result  ==  unsafe { nil }  {
return false ,unsafe { nil } 
}
return true ,unsafe { nil } 
}

fn (mut et ExpressionTree) replace(sourceValue_14 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_14.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Replace\" function source value, first argument, must be a \"String\"" ,) 
}
if testValue_5.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Replace\" function test value, second argument, must be a \"String\"" ,) 
}
if replace_value.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Replace\" function replace value, third argument, must be a \"String\"" ,) 
}
if testValue_5.is_null() {
return unsafe { nil } ,errors.new("\"Replace\" function test value, second argument, is null" ,) 
}
if replace_value.is_null() {
return unsafe { nil } ,errors.new("\"Replace\" function replace value, third argument, is null" ,) 
}
if sourceValue_14.is_null() {
return sourceValue_14 ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"Replace\" function optional ignore case value, fourth argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
mut regex,err_1:=regexp.compile("(?i)"  +  regexp.quote_meta(testValue_5.string_value() ,)  ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while compiling \"Replace\" function case-insensitive RegEx replace expression for test value, second argument: "  +  err_1.error()  ,) 
}
return new_value_expression(expression_value_type.string ,regex.replace_all_string(sourceValue_14.string_value() ,replace_value.string_value() ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,strings.replace_all(sourceValue_14.string_value() ,testValue_5.string_value() ,replace_value.string_value() ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) reverse(sourceValue_15 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_15.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Reverse\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_15.is_null() {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
mut chars:=sourceValue_15.string_value() .bytes()  
for i,j:=0 ,chars .len  -  1   ;i  <  chars .len  /  2   ;i,j=i  +  1  ,j  -  1    {
chars[i ],chars[j ]=chars[j ] ,chars[i ]  
}
return new_value_expression(expression_value_type.string ,chars .str() ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) round(sourceValue_16 &ValueExpression) (&ValueExpression, error, ) {if ! sourceValue_16.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Round\" function source value, first argument, must be numeric" ,) 
}
if sourceValue_16.is_null() {
return null_value(sourceValue_16.value_type() ,) ,unsafe { nil } 
}
if sourceValue_16.value_type.is_integer_type() {
return sourceValue_16 ,unsafe { nil } 
}
 match sourceValue_16.value_type() {expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,sourceValue_16.decimal_value.round(0 ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.round(sourceValue_16.double_value() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

// https://play.golang.org/p/_7nc06C
fn split_nth_index(source string, index_1 int) ([]int, ) {mut first_index:=find_nth_index(source ,test ,index_1  -  1  ,)  
mut second_index:=find_nth_index(source ,test ,index_1 ,)  
if first_index  <=  0   &&  second_index  <=  0   {
return unsafe { nil } 
}
if first_index  <=  0  {
return [0 ,second_index ] 
}
if second_index  <=  0  {
return [first_index  +  test .len  ,source .len ] 
}
return [first_index  +  test .len  ,second_index ] 
}

fn (mut et ExpressionTree) split(sourceValue_17 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_17.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Split\" function source value, first argument, must be a \"String\"" ,) 
}
if delimiter_value.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Split\" function delimeter value, second argument, must be a \"String\"" ,) 
}
if ! index_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("\"Split\" function index value, third argument, must be an integer type" ,) 
}
if delimiter_value.is_null() {
return unsafe { nil } ,errors.new("\"Split\" delimiter test value, second argument, is null" ,) 
}
if index_value.is_null() {
return unsafe { nil } ,errors.new("\"Split\" function index value, third argument, is null" ,) 
}
if sourceValue_17.is_null() {
return sourceValue_17 ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"Split\" function optional ignore case value, fourth argument, to \"Boolean\": "  +  err.error()  ,) 
}
mut index:=index_value.integer_value(- 1  ,)  
mut result:=[]int{} 
if ignore_case.boolean_value() {
result=split_nth_index(sourceValue_17.string_value() .to_upper() ,delimiter_value.string_value() .to_upper() ,index ,)  
}else {
result=split_nth_index(sourceValue_17.string_value() ,delimiter_value.string_value() ,index ,)  
}
if result  ==  unsafe { nil }  {
return empty_string ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,[result[0 ] ..result[1 ] ] ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) sqrt(sourceValue_18 &ValueExpression) (&ValueExpression, error, ) {if ! sourceValue_18.value_type.is_numeric_type()  {
return unsafe { nil } ,errors.new("\"Sqrt\" function source value, first argument, must be numeric" ,) 
}
if sourceValue_18.is_null() {
return null_value(sourceValue_18.value_type() ,) ,unsafe { nil } 
}
 match sourceValue_18.value_type() {expression_value_type.boolean {
return new_value_expression(expression_value_type.double ,math.sqrt(f64(sourceValue_18.boolean_value_as_int() ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.double ,math.sqrt(f64(sourceValue_18.int32_value() ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.double ,math.sqrt(f64(sourceValue_18.int64_value() ,) ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
mut f64,_:=sourceValue_18.decimal_value.float64()  
return new_value_expression(expression_value_type.double ,math.sqrt(f64 ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.sqrt(sourceValue_18.double_value() ,) ,) ,unsafe { nil } 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) starts_with(sourceValue_19 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_19.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"StartsWith\" function source value, first argument, must be a \"String\"" ,) 
}
if testValue_5.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"StartsWith\" function test value, second argument, must be a \"String\"" ,) 
}
if sourceValue_19.is_null() {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
if testValue_5.is_null() {
return false ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"StartsWith\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.boolean ,strings.has_prefix(sourceValue_19.string_value() .to_upper() ,testValue_5.string_value() .to_upper() ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.boolean ,strings.has_prefix(sourceValue_19.string_value() ,testValue_5.string_value() ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) str_count(sourceValue_20 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_20.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"StrCount\" function source value, first argument, must be a \"String\"" ,) 
}
if testValue_5.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"StrCount\" function test value, second argument, must be a \"String\"" ,) 
}
if sourceValue_20.is_null()  ||  testValue_5.is_null()  {
return new_value_expression(expression_value_type.int32 ,i32(0 ,) ,) ,unsafe { nil } 
}
mut find_value:=testValue_5.string_value()  
if find_value .len  ==  0  {
return new_value_expression(expression_value_type.int32 ,i32(0 ,) ,) ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"StrCount\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_20.string_value() .to_upper() .count(testValue_5.string_value() .to_upper() ,) ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.int32 ,i32(sourceValue_20.string_value() .count(testValue_5.string_value() ,) ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) str_cmp(leftValue_1 &ValueExpression) (&ValueExpression, error, ) {if leftValue_1.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"StrCmp\" function left value, first argument, must be a \"String\"" ,) 
}
if right_value.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"StrCmp\" function right value, second argument, must be a \"String\"" ,) 
}
if leftValue_1.is_null()  &&  right_value.is_null()  {
return new_value_expression(expression_value_type.int32 ,i32(0 ,) ,) ,unsafe { nil } 
}
if leftValue_1.is_null() {
return new_value_expression(expression_value_type.int32 ,i32(1 ,) ,) ,unsafe { nil } 
}
if right_value.is_null() {
return new_value_expression(expression_value_type.int32 ,i32(- 1  ,) ,) ,unsafe { nil } 
}
mut err:=error{} 
ignore_case,err=ignore_case.convert(expression_value_type.boolean ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed while converting \"StrCmp\" function optional ignore case value, third argument, to \"Boolean\": "  +  err.error()  ,) 
}
if ignore_case.boolean_value() {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_1.string_value() .to_upper() .compare(right_value.string_value() .to_upper() ,) ,) ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.int32 ,i32(leftValue_1.string_value() .compare(right_value.string_value() ,) ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) sub_str(sourceValue_21 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_21.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"SubStr\" function source value, first argument, must be a \"String\"" ,) 
}
if ! index_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("\"SubStr\" function index value, second argument, must be an integer type" ,) 
}
if ! length_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("\"SubStr\" function length value, third argument, must be an integer type" ,) 
}
if index_value.is_null() {
return unsafe { nil } ,errors.new("\"SubStr\" function index value, second argument, is null" ,) 
}
if sourceValue_21.is_null() {
return sourceValue_21 ,unsafe { nil } 
}
mut source_text:=sourceValue_21.string_value()  
mut index:=index_value.integer_value(0 ,)  
if index  <  0   ||  index  >=  source_text .len   {
return empty_string ,unsafe { nil } 
}
if ! length_value.is_null()  {
mut length:=length_value.integer_value(0 ,)  
if length  <=  0  {
return empty_string ,unsafe { nil } 
}
if index  +  length   <  source_text .len  {
return new_value_expression(expression_value_type.string ,source_text[index ..index  +  length  ] ,) ,unsafe { nil } 
}
}
return new_value_expression(expression_value_type.string ,source_text[index .. ] ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) trim(sourceValue_22 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_22.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Trim\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_22.is_null() {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,sourceValue_22.string_value() .trim_space() ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) trim_left(sourceValue_23 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_23.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"TrimLeft\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_23.is_null() {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,sourceValue_23.string_value() .trim_left(whitespace ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) trim_right(sourceValue_24 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_24.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"TrimRight\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_24.is_null() {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,sourceValue_24.string_value() .trim_right(whitespace ,) ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) upper(sourceValue_25 &ValueExpression) (&ValueExpression, error, ) {if sourceValue_25.value_type()  !=  expression_value_type.string  {
return unsafe { nil } ,errors.new("\"Upper\" function source value, first argument, must be a \"String\"" ,) 
}
if sourceValue_25.is_null() {
return null_value(expression_value_type.string ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.string ,sourceValue_25.string_value() .to_upper() ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) utc_now() (&ValueExpression, error, ) {return new_value_expression(expression_value_type.date_time ,time.now.utc() ,) ,unsafe { nil } 
}

fn convert_operands(leftValue_2 &&ValueExpression, valueType ExpressionValueTypeEnum) (error, ) {mut err:=error{} 
*leftValue_2,err=*leftValue_2.convert(valueType ,) 
if err  !=  unsafe { nil }  {
return errors.new("failed while converting left operand, to \""  +  valueType.string()   +  "\": "   +  err.error()  ,) 
}
*right_value,err=*right_value.convert(valueType ,) 
if err  !=  unsafe { nil }  {
return errors.new("failed while converting right operand, to \""  +  valueType.string()   +  "\": "   +  err.error()  ,) 
}
return unsafe { nil } 
}

fn (mut et ExpressionTree) multiply_op(leftValue_3 &ValueExpression, valueType_1 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_3.is_null()  ||  right_value.is_null()  {
return null_value(valueType_1 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_3  ,& right_value  ,valueType_1 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("multiplication \"*\" operator "  +  err.error()  ,) 
}
 match valueType_1 {expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_3.int32_value()  *  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_3.int64_value()  *  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,leftValue_3.decimal_value.mul(right_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,f64(leftValue_3.double_value()  *  right_value.double_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.boolean {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply multiplication \"*\" operator to \""  +  valueType_1.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) divide_op(leftValue_4 &ValueExpression, valueType_2 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_4.is_null()  ||  right_value.is_null()  {
return null_value(valueType_2 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_4  ,& right_value  ,valueType_2 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("division \"/\" operator "  +  err.error()  ,) 
}
 match valueType_2 {expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_4.int32_value()  /  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_4.int64_value()  /  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,leftValue_4.decimal_value.div(right_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,f64(leftValue_4.double_value()  /  right_value.double_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.boolean {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply division \"/\" operator to \""  +  valueType_2.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) modulus_op(leftValue_5 &ValueExpression, valueType_3 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_5.is_null()  ||  right_value.is_null()  {
return null_value(valueType_3 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_5  ,& right_value  ,valueType_3 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("modulus \"%\" operator "  +  err.error()  ,) 
}
 match valueType_3 {expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_5.int32_value()  %  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_5.int64_value()  %  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,leftValue_5.decimal_value.mod(right_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,math.mod(leftValue_5.double_value() ,right_value.double_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.boolean {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply modulus \"%\" operator to \""  +  valueType_3.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) add_op(leftValue_6 &ValueExpression, valueType_4 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_6.is_null()  ||  right_value.is_null()  {
return null_value(valueType_4 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_6  ,& right_value  ,valueType_4 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("addition \"+\" operator "  +  err.error()  ,) 
}
 match valueType_4 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_6.boolean_value_as_int()  +  right_value.boolean_value_as_int()   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_6.int32_value()  +  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_6.int64_value()  +  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,leftValue_6.decimal_value.add(right_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,f64(leftValue_6.double_value()  +  right_value.double_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression(expression_value_type.string ,leftValue_6.string_value()  +  right_value.string_value()  ,) ,unsafe { nil } 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply addition \"+\" operator to \""  +  valueType_4.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) subtract_op(leftValue_7 &ValueExpression, valueType_5 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_7.is_null()  ||  right_value.is_null()  {
return null_value(valueType_5 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_7  ,& right_value  ,valueType_5 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("subtraction \"-\" operator "  +  err.error()  ,) 
}
 match valueType_5 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_7.boolean_value_as_int()  -  right_value.boolean_value_as_int()   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_7.int32_value()  -  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_7.int64_value()  -  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.decimal ,leftValue_7.decimal_value.sub(right_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.double ,f64(leftValue_7.double_value()  -  right_value.double_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply subtraction \"-\" operator to \""  +  valueType_5.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

//gocyclo: ig
fn (mut et ExpressionTree) bit_shift_left_op(leftValue_8 &ValueExpression) (&ValueExpression, error, ) {if leftValue_8.is_null() {
return leftValue_8 ,unsafe { nil } 
}
if ! right_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("BitShift operation shift value must be an integer" ,) 
}
if right_value.is_null() {
return unsafe { nil } ,errors.new("BitShift operation shift value is null" ,) 
}
mut shift_amount:=right_value.integer_value(0 ,)  
 match leftValue_8.value_type() {expression_value_type.boolean {
if shift_amount  <  0  {
shift_amount=int_size  -  (abs(shift_amount ,)  %  int_size  )   
}
return new_value_expression(expression_value_type.boolean ,leftValue_8.boolean_value_as_int()  <<  shift_amount   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
if shift_amount  <  0  {
shift_amount=32  -  (abs(shift_amount ,)  %  32  )   
}
return new_value_expression(expression_value_type.int32 ,i32(i64(leftValue_8.int32_value() ,)  <<  shift_amount  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
if shift_amount  <  0  {
shift_amount=64  -  (abs(shift_amount ,)  %  64  )   
}
return new_value_expression(expression_value_type.int64 ,i64(u64(leftValue_8.int64_value() ,)  <<  shift_amount  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
fallthrough 
}
expression_value_type.double {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply left bit-shift \"<<\" operator to \""  +  leftValue_8.value_type.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

//gocyclo: ig
fn (mut et ExpressionTree) bit_shift_right_op(leftValue_9 &ValueExpression) (&ValueExpression, error, ) {if leftValue_9.is_null() {
return leftValue_9 ,unsafe { nil } 
}
if ! right_value.value_type.is_integer_type()  {
return unsafe { nil } ,errors.new("BitShift operation shift value must be an integer" ,) 
}
if right_value.is_null() {
return unsafe { nil } ,errors.new("BitShift operation shift value is null" ,) 
}
mut shift_amount:=right_value.integer_value(0 ,)  
 match leftValue_9.value_type() {expression_value_type.boolean {
if shift_amount  <  0  {
shift_amount=int_size  -  (abs(shift_amount ,)  %  int_size  )   
}
return new_value_expression(expression_value_type.boolean ,leftValue_9.boolean_value_as_int()  >>  shift_amount   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
if shift_amount  <  0  {
shift_amount=32  -  (abs(shift_amount ,)  %  32  )   
}
return new_value_expression(expression_value_type.int32 ,i32(i64(leftValue_9.int32_value() ,)  >>  shift_amount  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
if shift_amount  <  0  {
shift_amount=64  -  (abs(shift_amount ,)  %  64  )   
}
return new_value_expression(expression_value_type.int64 ,i64(u64(leftValue_9.int64_value() ,)  >>  shift_amount  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
fallthrough 
}
expression_value_type.double {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply right bit-shift \">>\" operator to \""  +  leftValue_9.value_type.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) bitwise_and_op(leftValue_10 &ValueExpression, valueType_6 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_10.is_null()  ||  right_value.is_null()  {
return null_value(valueType_6 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_10  ,& right_value  ,valueType_6 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("bitwise \"&\" operator "  +  err.error()  ,) 
}
 match valueType_6 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_10.boolean_value_as_int()  &  right_value.boolean_value_as_int()   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_10.int32_value()  &  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_10.int64_value()  &  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
fallthrough 
}
expression_value_type.double {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply bitwise \"&\" operator to \""  +  valueType_6.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) bitwise_or_op(leftValue_11 &ValueExpression, valueType_7 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_11.is_null()  ||  right_value.is_null()  {
return null_value(valueType_7 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_11  ,& right_value  ,valueType_7 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("bitwise \"|\" operator "  +  err.error()  ,) 
}
 match valueType_7 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_11.boolean_value_as_int()  |  right_value.boolean_value_as_int()   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_11.int32_value()  |  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_11.int64_value()  |  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
fallthrough 
}
expression_value_type.double {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply bitwise \"|\" operator to \""  +  valueType_7.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) bitwise_xor_op(leftValue_12 &ValueExpression, valueType_8 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_12.is_null()  ||  right_value.is_null()  {
return null_value(valueType_8 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_12  ,& right_value  ,valueType_8 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("bitwise \"^\" operator "  +  err.error()  ,) 
}
 match valueType_8 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_12.boolean_value_as_int()  ^  right_value.boolean_value_as_int()   !=  0  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.int32 ,i32(leftValue_12.int32_value()  ^  right_value.int32_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.int64 ,i64(leftValue_12.int64_value()  ^  right_value.int64_value()  ,) ,) ,unsafe { nil } 
}
expression_value_type.decimal {
fallthrough 
}
expression_value_type.double {
fallthrough 
}
expression_value_type.string {
fallthrough 
}
expression_value_type.guid {
fallthrough 
}
expression_value_type.date_time {
fallthrough 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply bitwise \"^\" operator to \""  +  valueType_8.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) less_than_op(leftValue_13 &ValueExpression, valueType_9 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_13.is_null()  ||  right_value.is_null()  {
return null_value(valueType_9 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_13  ,& right_value  ,valueType_9 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("less than \"<\" operator "  +  err.error()  ,) 
}
 match valueType_9 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_13.boolean_value_as_int()  <  right_value.boolean_value_as_int()  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.boolean ,leftValue_13.int32_value()  <  right_value.int32_value()  ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.boolean ,leftValue_13.int64_value()  <  right_value.int64_value()  ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.boolean ,leftValue_13.decimal_value.cmp(right_value.decimal_value() ,)  <  0  ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.boolean ,leftValue_13.double_value()  <  right_value.double_value()  ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression(expression_value_type.boolean ,leftValue_13.string_value() .to_upper()  <  right_value.string_value() .to_upper()  ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression(expression_value_type.boolean ,guid.compare(leftValue_13.guid_value() ,right_value.guid_value() ,)  <  0  ,) ,unsafe { nil } 
}
expression_value_type.date_time {
return new_value_expression(expression_value_type.boolean ,leftValue_13.date_time_value.before(right_value.date_time_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply less than \"<\" operator to \""  +  valueType_9.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) less_than_or_equal_op(leftValue_14 &ValueExpression, valueType_10 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_14.is_null()  ||  right_value.is_null()  {
return null_value(valueType_10 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_14  ,& right_value  ,valueType_10 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("less than or equal \"<=\" operator "  +  err.error()  ,) 
}
 match valueType_10 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_14.boolean_value_as_int()  <=  right_value.boolean_value_as_int()  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.boolean ,leftValue_14.int32_value()  <=  right_value.int32_value()  ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.boolean ,leftValue_14.int64_value()  <=  right_value.int64_value()  ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.boolean ,leftValue_14.decimal_value.cmp(right_value.decimal_value() ,)  <=  0  ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.boolean ,leftValue_14.double_value()  <=  right_value.double_value()  ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression(expression_value_type.boolean ,leftValue_14.string_value() .to_upper()  <=  right_value.string_value() .to_upper()  ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression(expression_value_type.boolean ,guid.compare(leftValue_14.guid_value() ,right_value.guid_value() ,)  <=  0  ,) ,unsafe { nil } 
}
expression_value_type.date_time {
mut left:=leftValue_14.date_time_value()  
mut right:=right_value.date_time_value()  
return new_value_expression(expression_value_type.boolean ,left.before(right ,)  ||  left.equal(right ,)  ,) ,unsafe { nil } 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply less than or equal \"<=\" operator to \""  +  valueType_10.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) greater_than_op(leftValue_15 &ValueExpression, valueType_11 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_15.is_null()  ||  right_value.is_null()  {
return null_value(valueType_11 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_15  ,& right_value  ,valueType_11 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("greater than \">\" operator "  +  err.error()  ,) 
}
 match valueType_11 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_15.boolean_value_as_int()  >  right_value.boolean_value_as_int()  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.boolean ,leftValue_15.int32_value()  >  right_value.int32_value()  ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.boolean ,leftValue_15.int64_value()  >  right_value.int64_value()  ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.boolean ,leftValue_15.decimal_value.cmp(right_value.decimal_value() ,)  >  0  ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.boolean ,leftValue_15.double_value()  >  right_value.double_value()  ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression(expression_value_type.boolean ,leftValue_15.string_value() .to_upper()  >  right_value.string_value() .to_upper()  ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression(expression_value_type.boolean ,guid.compare(leftValue_15.guid_value() ,right_value.guid_value() ,)  >  0  ,) ,unsafe { nil } 
}
expression_value_type.date_time {
return new_value_expression(expression_value_type.boolean ,leftValue_15.date_time_value.after(right_value.date_time_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply greater than \">\" operator to \""  +  valueType_11.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) greater_than_or_equal_op(leftValue_16 &ValueExpression, valueType_12 ExpressionValueTypeEnum) (&ValueExpression, error, ) {if leftValue_16.is_null()  ||  right_value.is_null()  {
return null_value(valueType_12 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_16  ,& right_value  ,valueType_12 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("greater than or equal \">=\" operator "  +  err.error()  ,) 
}
 match valueType_12 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_16.boolean_value_as_int()  >=  right_value.boolean_value_as_int()  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.boolean ,leftValue_16.int32_value()  >=  right_value.int32_value()  ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.boolean ,leftValue_16.int64_value()  >=  right_value.int64_value()  ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.boolean ,leftValue_16.decimal_value.cmp(right_value.decimal_value() ,)  >=  0  ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.boolean ,leftValue_16.double_value()  >=  right_value.double_value()  ,) ,unsafe { nil } 
}
expression_value_type.string {
return new_value_expression(expression_value_type.boolean ,leftValue_16.string_value() .to_upper()  >=  right_value.string_value() .to_upper()  ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression(expression_value_type.boolean ,guid.compare(leftValue_16.guid_value() ,right_value.guid_value() ,)  >=  0  ,) ,unsafe { nil } 
}
expression_value_type.date_time {
mut left:=leftValue_16.date_time_value()  
mut right:=right_value.date_time_value()  
return new_value_expression(expression_value_type.boolean ,left.after(right ,)  ||  left.equal(right ,)  ,) ,unsafe { nil } 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply greater than or equal \">=\" operator to \""  +  valueType_12.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) equal_op(leftValue_17 &ValueExpression, valueType_13 ExpressionValueTypeEnum, exactMatch bool) (&ValueExpression, error, ) {if leftValue_17.is_null()  ||  right_value.is_null()  {
return null_value(valueType_13 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_17  ,& right_value  ,valueType_13 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("equal \"=\" operator "  +  err.error()  ,) 
}
 match valueType_13 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_17.boolean_value_as_int()  ==  right_value.boolean_value_as_int()  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.boolean ,leftValue_17.int32_value()  ==  right_value.int32_value()  ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.boolean ,leftValue_17.int64_value()  ==  right_value.int64_value()  ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.boolean ,leftValue_17.decimal_value.equal(right_value.decimal_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.boolean ,leftValue_17.double_value()  ==  right_value.double_value()  ,) ,unsafe { nil } 
}
expression_value_type.string {
if exactMatch {
return new_value_expression(expression_value_type.boolean ,leftValue_17.string_value()  ==  right_value.string_value()  ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.boolean ,strings.equal_fold(leftValue_17.string_value() ,right_value.string_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression(expression_value_type.boolean ,leftValue_17.guid_value.equal(right_value.guid_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.date_time {
return new_value_expression(expression_value_type.boolean ,leftValue_17.date_time_value.equal(right_value.date_time_value() ,) ,) ,unsafe { nil } 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply equal \"=\" operator to \""  +  valueType_13.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) not_equal_op(leftValue_18 &ValueExpression, valueType_14 ExpressionValueTypeEnum, exactMatch_1 bool) (&ValueExpression, error, ) {if leftValue_18.is_null()  ||  right_value.is_null()  {
return null_value(valueType_14 ,) ,unsafe { nil } 
}
mut err:=convert_operands(& leftValue_18  ,& right_value  ,valueType_14 ,) 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,errors.new("not equal \"!=\" operator "  +  err.error()  ,) 
}
 match valueType_14 {expression_value_type.boolean {
return new_value_expression(expression_value_type.boolean ,leftValue_18.boolean_value_as_int()  !=  right_value.boolean_value_as_int()  ,) ,unsafe { nil } 
}
expression_value_type.int32 {
return new_value_expression(expression_value_type.boolean ,leftValue_18.int32_value()  !=  right_value.int32_value()  ,) ,unsafe { nil } 
}
expression_value_type.int64 {
return new_value_expression(expression_value_type.boolean ,leftValue_18.int64_value()  !=  right_value.int64_value()  ,) ,unsafe { nil } 
}
expression_value_type.decimal {
return new_value_expression(expression_value_type.boolean ,! leftValue_18.decimal_value.equal(right_value.decimal_value() ,)  ,) ,unsafe { nil } 
}
expression_value_type.double {
return new_value_expression(expression_value_type.boolean ,leftValue_18.double_value()  !=  right_value.double_value()  ,) ,unsafe { nil } 
}
expression_value_type.string {
if exactMatch_1 {
return new_value_expression(expression_value_type.boolean ,leftValue_18.string_value()  !=  right_value.string_value()  ,) ,unsafe { nil } 
}
return new_value_expression(expression_value_type.boolean ,! strings.equal_fold(leftValue_18.string_value() ,right_value.string_value() ,)  ,) ,unsafe { nil } 
}
expression_value_type.guid {
return new_value_expression(expression_value_type.boolean ,! leftValue_18.guid_value.equal(right_value.guid_value() ,)  ,) ,unsafe { nil } 
}
expression_value_type.date_time {
return new_value_expression(expression_value_type.boolean ,! leftValue_18.date_time_value.equal(right_value.date_time_value() ,)  ,) ,unsafe { nil } 
}
expression_value_type.undefined {
return unsafe { nil } ,errors.new("cannot apply not equal \"!=\" operator to \""  +  valueType_14.string()   +  "\""  ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected expression value type encountered" ,) 
}
}
}

fn (mut et ExpressionTree) is_null_op(leftValue_19 &ValueExpression) (&ValueExpression, ) {return new_value_expression(expression_value_type.boolean ,leftValue_19.is_null() ,) 
}

fn (mut et ExpressionTree) is_not_null_op(leftValue_20 &ValueExpression) (&ValueExpression, ) {return new_value_expression(expression_value_type.boolean ,! leftValue_20.is_null()  ,) 
}

//gocyclo:ig
fn (mut et ExpressionTree) like_op(leftValue_21 &ValueExpression, exactMatch_2 bool) (&ValueExpression, error, ) {if leftValue_21.is_null() {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
if leftValue_21.value_type()  !=  expression_value_type.string   ||  right_value.value_type()  !=  expression_value_type.string   {
return unsafe { nil } ,errors.new("cannot perform \"LIKE\" operation on \""  +  leftValue_21.value_type.string()   +  "\" and \""   +  right_value.value_type.string()   +  "\""  ,) 
}
if right_value.is_null() {
return unsafe { nil } ,errors.new("right operand of \"LIKE\" expression is null" ,) 
}
mut left_operand:=leftValue_21.string_value()  
mut right_operand:=right_value.string_value()  
mut test_expression:=strings.replace_all(right_operand ,"%" ,"*" ,)  
mut starts_with_wildcard:=strings.has_prefix(test_expression ,"*" ,)  
mut ends_with_wildcard:=strings.has_suffix(test_expression ,"*" ,)  
if starts_with_wildcard {
test_expression=test_expression[1 .. ]  
}
if ends_with_wildcard  &&  test_expression .len  >  0   {
test_expression=test_expression[ ..test_expression .len  -  1  ]  
}
if test_expression .len  ==  0  {
return true ,unsafe { nil } 
}
if strings.contains_rune(test_expression ,`*` ,) {
return unsafe { nil } ,errors.new("right operand of \"LIKE\" expression \""  +  right_operand   +  "\" has an invalid pattern"  ,) 
}
if starts_with_wildcard {
if exactMatch_2 {
if strings.has_suffix(left_operand ,test_expression ,) {
return true ,unsafe { nil } 
}
}else {
if strings.has_suffix(left_operand .to_upper() ,test_expression .to_upper() ,) {
return true ,unsafe { nil } 
}
}
}
if ends_with_wildcard {
if exactMatch_2 {
if strings.has_prefix(left_operand ,test_expression ,) {
return true ,unsafe { nil } 
}
}else {
if strings.has_prefix(left_operand .to_upper() ,test_expression .to_upper() ,) {
return true ,unsafe { nil } 
}
}
}
if starts_with_wildcard  &&  ends_with_wildcard  {
if exactMatch_2 {
if left_operand .contains(test_expression ,) {
return true ,unsafe { nil } 
}
}else {
if left_operand .to_upper() .contains(test_expression .to_upper() ,) {
return true ,unsafe { nil } 
}
}
}
return false ,unsafe { nil } 
}

fn (mut et ExpressionTree) not_like_op(leftValue_22 &ValueExpression, exactMatch_3 bool) (&ValueExpression, error, ) {if leftValue_22.is_null() {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
mut like_result,err:=et.like_op(leftValue_22 ,right_value ,exactMatch_3 ,)  
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
if like_result.boolean_value() {
return false ,unsafe { nil } 
}
return true ,unsafe { nil } 
}

fn (mut et ExpressionTree) and_op(leftValue_23 &ValueExpression) (&ValueExpression, error, ) {if leftValue_23.is_null()  ||  right_value.is_null()  {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
if leftValue_23.value_type()  !=  expression_value_type.boolean   ||  right_value.value_type()  !=  expression_value_type.boolean   {
return unsafe { nil } ,errors.new("cannot perform \"AND\" operation on \""  +  leftValue_23.value_type.string()   +  "\" and \""   +  right_value.value_type.string()   +  "\""  ,) 
}
return new_value_expression(expression_value_type.boolean ,leftValue_23.boolean_value()  &&  right_value.boolean_value()  ,) ,unsafe { nil } 
}

fn (mut et ExpressionTree) or_op(leftValue_24 &ValueExpression) (&ValueExpression, error, ) {if leftValue_24.is_null()  ||  right_value.is_null()  {
return null_value(expression_value_type.boolean ,) ,unsafe { nil } 
}
if leftValue_24.value_type()  !=  expression_value_type.boolean   ||  right_value.value_type()  !=  expression_value_type.boolean   {
return unsafe { nil } ,errors.new("cannot perform \"OR\" operation on \""  +  leftValue_24.value_type.string()   +  "\" and \""   +  right_value.value_type.string()   +  "\""  ,) 
}
return new_value_expression(expression_value_type.boolean ,leftValue_24.boolean_value()  ||  right_value.boolean_value()  ,) ,unsafe { nil } 
}
