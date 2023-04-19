module data

import strconv
import strings

const (
	expression_type            = NOT_YET_IMPLEMENTED
	expression_value_type      = NOT_YET_IMPLEMENTED
	zero_expression_value_type = ExpressionValueTypeEnum(0)
	expression_unary_type      = NOT_YET_IMPLEMENTED
	expression_function_type   = NOT_YET_IMPLEMENTED
	expression_operator_type   = NOT_YET_IMPLEMENTED
	time_interval              = NOT_YET_IMPLEMENTED
)

type ExpressionTypeEnum = int
type ExpressionValueTypeEnum = int
type ExpressionUnaryTypeEnum = int
type ExpressionFunctionTypeEnum = int
type ExpressionOperatorTypeEnum = int
type TimeIntervalEnum = int

struct Go2VInlineStruct {
mut:
	value    ExpressionTypeEnum
	unary    ExpressionTypeEnum
	column   ExpressionTypeEnum
	in_list  ExpressionTypeEnum
	function ExpressionTypeEnum
	operator ExpressionTypeEnum
}

struct Go2VInlineStruct_1 {
mut:
	boolean   ExpressionValueTypeEnum
	i32       ExpressionValueTypeEnum
	i64       ExpressionValueTypeEnum
	decimal   ExpressionValueTypeEnum
	double    ExpressionValueTypeEnum
	string    ExpressionValueTypeEnum
	guid      ExpressionValueTypeEnum
	date_time ExpressionValueTypeEnum
	undefined ExpressionValueTypeEnum
}

struct Go2VInlineStruct_2 {
mut:
	plus  ExpressionUnaryTypeEnum
	minus ExpressionUnaryTypeEnum
	not   ExpressionUnaryTypeEnum
}

struct Go2VInlineStruct_3 {
mut:
	abs           ExpressionFunctionTypeEnum
	ceiling       ExpressionFunctionTypeEnum
	coalesce      ExpressionFunctionTypeEnum
	convert       ExpressionFunctionTypeEnum
	contains      ExpressionFunctionTypeEnum
	date_add      ExpressionFunctionTypeEnum
	date_diff     ExpressionFunctionTypeEnum
	date_part     ExpressionFunctionTypeEnum
	ends_with     ExpressionFunctionTypeEnum
	floor         ExpressionFunctionTypeEnum
	iif           ExpressionFunctionTypeEnum
	index_of      ExpressionFunctionTypeEnum
	is_date       ExpressionFunctionTypeEnum
	is_integer    ExpressionFunctionTypeEnum
	is_guid       ExpressionFunctionTypeEnum
	is_null       ExpressionFunctionTypeEnum
	is_numeric    ExpressionFunctionTypeEnum
	last_index_of ExpressionFunctionTypeEnum
	len           ExpressionFunctionTypeEnum
	lower         ExpressionFunctionTypeEnum
	max_of        ExpressionFunctionTypeEnum
	min_of        ExpressionFunctionTypeEnum
	now           ExpressionFunctionTypeEnum
	nth_index_of  ExpressionFunctionTypeEnum
	power         ExpressionFunctionTypeEnum
	reg_ex_match  ExpressionFunctionTypeEnum
	reg_ex_val    ExpressionFunctionTypeEnum
	replace       ExpressionFunctionTypeEnum
	reverse       ExpressionFunctionTypeEnum
	round         ExpressionFunctionTypeEnum
	split         ExpressionFunctionTypeEnum
	sqrt          ExpressionFunctionTypeEnum
	starts_with   ExpressionFunctionTypeEnum
	str_count     ExpressionFunctionTypeEnum
	str_cmp       ExpressionFunctionTypeEnum
	sub_str       ExpressionFunctionTypeEnum
	trim          ExpressionFunctionTypeEnum
	trim_left     ExpressionFunctionTypeEnum
	trim_right    ExpressionFunctionTypeEnum
	upper         ExpressionFunctionTypeEnum
	utc_now       ExpressionFunctionTypeEnum
}

struct Go2VInlineStruct_4 {
mut:
	multiply              ExpressionOperatorTypeEnum
	divide                ExpressionOperatorTypeEnum
	modulus               ExpressionOperatorTypeEnum
	add                   ExpressionOperatorTypeEnum
	subtract              ExpressionOperatorTypeEnum
	bit_shift_left        ExpressionOperatorTypeEnum
	bit_shift_right       ExpressionOperatorTypeEnum
	bitwise_and           ExpressionOperatorTypeEnum
	bitwise_or            ExpressionOperatorTypeEnum
	bitwise_xor           ExpressionOperatorTypeEnum
	less_than             ExpressionOperatorTypeEnum
	less_than_or_equal    ExpressionOperatorTypeEnum
	greater_than          ExpressionOperatorTypeEnum
	greater_than_or_equal ExpressionOperatorTypeEnum
	equal                 ExpressionOperatorTypeEnum
	equal_exact_match     ExpressionOperatorTypeEnum
	not_equal             ExpressionOperatorTypeEnum
	not_equal_exact_match ExpressionOperatorTypeEnum
	is_null               ExpressionOperatorTypeEnum
	is_not_null           ExpressionOperatorTypeEnum
	like                  ExpressionOperatorTypeEnum
	like_exact_match      ExpressionOperatorTypeEnum
	not_like              ExpressionOperatorTypeEnum
	not_like_exact_match  ExpressionOperatorTypeEnum
	and                   ExpressionOperatorTypeEnum
	@or                   ExpressionOperatorTypeEnum
}

struct Go2VInlineStruct_5 {
mut:
	year        TimeIntervalEnum
	month       TimeIntervalEnum
	day_of_year TimeIntervalEnum
	day         TimeIntervalEnum
	week        TimeIntervalEnum
	week_day    TimeIntervalEnum
	hour        TimeIntervalEnum
	minute      TimeIntervalEnum
	second      TimeIntervalEnum
	millisecond TimeIntervalEnum
}

// String gets the ExpressionType enumeration value as a str
pub fn (mut ete ExpressionTypeEnum) string() string {
	match ete {
		data.expression_type.value {
			return 'Value'
		}
		data.expression_type.unary {
			return 'Unary'
		}
		data.expression_type.column {
			return 'Column'
		}
		data.expression_type.in_list {
			return 'InList'
		}
		data.expression_type.function {
			return 'Function'
		}
		data.expression_type.operator {
			return 'Operator'
		}
		else {
			return '0x' + strconv.format_int(i64(ete), 16)
		}
	}
}

// ExpressionValueTypeLen gets the number of elements in the ExpressionValueType enumerat
pub fn expression_value_type_len() int {
	return int(data.expression_value_type.undefined) + 1
}

// String gets the ExpressionValueType enumeration value as a str
pub fn (mut evte ExpressionValueTypeEnum) string_1() string {
	match evte {
		data.expression_value_type.boolean {
			return 'Boolean'
		}
		data.expression_value_type.int32 {
			return 'Int32'
		}
		data.expression_value_type.int64 {
			return 'Int64'
		}
		data.expression_value_type.decimal {
			return 'Decimal'
		}
		data.expression_value_type.double {
			return 'Double'
		}
		data.expression_value_type.string {
			return 'String'
		}
		data.expression_value_type.guid {
			return 'Guid'
		}
		data.expression_value_type.date_time {
			return 'DateTime'
		}
		data.expression_value_type.undefined {
			return 'Undefined'
		}
		else {
			return '0x' + strconv.format_int(i64(evte), 16)
		}
	}
}

// IsIntegerType gets a flag that determines if the ExpressionValueType enumeration value represents an integer t
pub fn (mut evte ExpressionValueTypeEnum) is_integer_type() bool {
	match evte {
		data.expression_value_type.boolean {
			return true
		}
		data.expression_value_type.int32 {
			return true
		}
		data.expression_value_type.int64 {
			return true
		}
		else {
			return false
		}
	}
}

// IsNumericType gets a flag that determines if the ExpressionValueType enumeration value represents a numeric t
pub fn (mut evte ExpressionValueTypeEnum) is_numeric_type() bool {
	match evte {
		data.expression_value_type.boolean {
			return true
		}
		data.expression_value_type.int32 {
			return true
		}
		data.expression_value_type.int64 {
			return true
		}
		data.expression_value_type.decimal {
			return true
		}
		data.expression_value_type.double {
			return true
		}
		else {
			return false
		}
	}
}

// String gets the ExpressionUnaryType enumeration value as a str
pub fn (mut eute ExpressionUnaryTypeEnum) string_2() string {
	match eute {
		data.expression_unary_type.plus {
			return '+'
		}
		data.expression_unary_type.minus {
			return '-'
		}
		data.expression_unary_type.not {
			return '~'
		}
		else {
			return '0x' + strconv.format_int(i64(eute), 16)
		}
	}
}

// String gets the ExpressionFunctionType enumeration value as a str
pub fn (mut efte ExpressionFunctionTypeEnum) string_3() string {
	match efte {
		data.expression_function_type.abs {
			return 'Abs'
		}
		data.expression_function_type.ceiling {
			return 'Ceiling'
		}
		data.expression_function_type.coalesce {
			return 'Coalesce'
		}
		data.expression_function_type.convert {
			return 'Convert'
		}
		data.expression_function_type.contains {
			return 'Contains'
		}
		data.expression_function_type.date_add {
			return 'DateAdd'
		}
		data.expression_function_type.date_diff {
			return 'DateDiff'
		}
		data.expression_function_type.date_part {
			return 'DatePart'
		}
		data.expression_function_type.ends_with {
			return 'EndsWith'
		}
		data.expression_function_type.floor {
			return 'Floor'
		}
		data.expression_function_type.iif {
			return 'IIf'
		}
		data.expression_function_type.index_of {
			return 'IndexOf'
		}
		data.expression_function_type.is_date {
			return 'IsDate'
		}
		data.expression_function_type.is_integer {
			return 'IsInteger'
		}
		data.expression_function_type.is_guid {
			return 'IsGuid'
		}
		data.expression_function_type.is_null {
			return 'IsNull'
		}
		data.expression_function_type.is_numeric {
			return 'IsNumeric'
		}
		data.expression_function_type.last_index_of {
			return 'LastIndexOf'
		}
		data.expression_function_type.len {
			return 'Len'
		}
		data.expression_function_type.lower {
			return 'Lower'
		}
		data.expression_function_type.max_of {
			return 'MaxOf'
		}
		data.expression_function_type.min_of {
			return 'MinOf'
		}
		data.expression_function_type.now {
			return 'Now'
		}
		data.expression_function_type.nth_index_of {
			return 'NthIndexOf'
		}
		data.expression_function_type.power {
			return 'Power'
		}
		data.expression_function_type.reg_ex_match {
			return 'RegExMatch'
		}
		data.expression_function_type.reg_ex_val {
			return 'RegExVal'
		}
		data.expression_function_type.replace {
			return 'Replace'
		}
		data.expression_function_type.reverse {
			return 'Reverse'
		}
		data.expression_function_type.round {
			return 'Round'
		}
		data.expression_function_type.split {
			return 'Split'
		}
		data.expression_function_type.sqrt {
			return 'Sqrt'
		}
		data.expression_function_type.starts_with {
			return 'StartsWith'
		}
		data.expression_function_type.str_count {
			return 'StrCount'
		}
		data.expression_function_type.str_cmp {
			return 'StrCmp'
		}
		data.expression_function_type.sub_str {
			return 'SubStr'
		}
		data.expression_function_type.trim {
			return 'Trim'
		}
		data.expression_function_type.trim_left {
			return 'TrimLeft'
		}
		data.expression_function_type.trim_right {
			return 'TrimRight'
		}
		data.expression_function_type.upper {
			return 'Upper'
		}
		data.expression_function_type.utc_now {
			return 'UtcNow'
		}
		else {
			return '0x' + strconv.format_int(i64(efte), 16)
		}
	}
}

// String gets the ExpressionOperatorType enumeration value as a str
pub fn (mut eote ExpressionOperatorTypeEnum) string_4() string {
	match eote {
		data.expression_operator_type.multiply {
			return '*'
		}
		data.expression_operator_type.divide {
			return '/'
		}
		data.expression_operator_type.modulus {
			return '%'
		}
		data.expression_operator_type.add {
			return '+'
		}
		data.expression_operator_type.subtract {
			return '-'
		}
		data.expression_operator_type.bit_shift_left {
			return '<<'
		}
		data.expression_operator_type.bit_shift_right {
			return '>>'
		}
		data.expression_operator_type.bitwise_and {
			return '&'
		}
		data.expression_operator_type.bitwise_or {
			return '|'
		}
		data.expression_operator_type.bitwise_xor {
			return '^'
		}
		data.expression_operator_type.less_than {
			return '<'
		}
		data.expression_operator_type.less_than_or_equal {
			return '<='
		}
		data.expression_operator_type.greater_than {
			return '>'
		}
		data.expression_operator_type.greater_than_or_equal {
			return '>='
		}
		data.expression_operator_type.equal {
			return '='
		}
		data.expression_operator_type.equal_exact_match {
			return '==='
		}
		data.expression_operator_type.not_equal {
			return '<>'
		}
		data.expression_operator_type.not_equal_exact_match {
			return '!=='
		}
		data.expression_operator_type.is_null {
			return 'IS NULL'
		}
		data.expression_operator_type.is_not_null {
			return 'IS NOT NULL'
		}
		data.expression_operator_type.like {
			return 'LIKE'
		}
		data.expression_operator_type.like_exact_match {
			return 'LIKE BINARY'
		}
		data.expression_operator_type.not_like {
			return 'NOT LIKE'
		}
		data.expression_operator_type.not_like_exact_match {
			return 'NOT LIKE BINARY'
		}
		data.expression_operator_type.and {
			return 'AND'
		}
		data.expression_operator_type.@or {
			return 'OR'
		}
		else {
			return '0x' + strconv.format_int(i64(eote), 16)
		}
	}
}

// ParseTimeInterval gets the TimeInterval parsed from the specified name. Case insensit
pub fn parse_time_interval(name string) (TimeIntervalEnum, error) {
	name = name.trim_space().to_upper()
	match name {
		'YEAR' {
			return data.time_interval.year, unsafe { nil }
		}
		'MONTH' {
			return data.time_interval.month, unsafe { nil }
		}
		'DAYOFYEAR' {
			return data.time_interval.day_of_year, unsafe { nil }
		}
		'DAY' {
			return data.time_interval.day, unsafe { nil }
		}
		'WEEK' {
			return data.time_interval.week, unsafe { nil }
		}
		'WEEKDAY' {
			return data.time_interval.week_day, unsafe { nil }
		}
		'HOUR' {
			return data.time_interval.hour, unsafe { nil }
		}
		'MINUTE' {
			return data.time_interval.minute, unsafe { nil }
		}
		'SECOND' {
			return data.time_interval.second, unsafe { nil }
		}
		'MILLISECOND' {
			return data.time_interval.millisecond, unsafe { nil }
		}
		else {
			return data.time_interval.year, error(strconv.v_sprintf('specified time interval "%s" is unrecognized',
				name))
		}
	}
}

// gocyclo:ig
fn (mut eote ExpressionOperatorTypeEnum) derive_operation_value_type(leftValueType ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match eote {
		data.expression_operator_type.multiply {
			fallthrough
		}
		data.expression_operator_type.divide {
			fallthrough
		}
		data.expression_operator_type.add {
			fallthrough
		}
		data.expression_operator_type.subtract {
			return eote.derive_arithmetic_operation_value_type(leftValueType, right_value_type)
		}
		data.expression_operator_type.modulus {
			fallthrough
		}
		data.expression_operator_type.bitwise_and {
			fallthrough
		}
		data.expression_operator_type.bitwise_or {
			fallthrough
		}
		data.expression_operator_type.bitwise_xor {
			return eote.derive_integer_operation_value_type(leftValueType, right_value_type)
		}
		data.expression_operator_type.less_than {
			fallthrough
		}
		data.expression_operator_type.less_than_or_equal {
			fallthrough
		}
		data.expression_operator_type.greater_than {
			fallthrough
		}
		data.expression_operator_type.greater_than_or_equal {
			fallthrough
		}
		data.expression_operator_type.equal {
			fallthrough
		}
		data.expression_operator_type.equal_exact_match {
			fallthrough
		}
		data.expression_operator_type.not_equal {
			fallthrough
		}
		data.expression_operator_type.not_equal_exact_match {
			return eote.derive_comparison_operation_value_type(leftValueType, right_value_type)
		}
		data.expression_operator_type.and {
			fallthrough
		}
		data.expression_operator_type.@or {
			return eote.derive_boolean_operation_value_type(leftValueType, right_value_type)
		}
		data.expression_operator_type.bit_shift_left {
			fallthrough
		}
		data.expression_operator_type.bit_shift_right {
			fallthrough
		}
		data.expression_operator_type.is_null {
			fallthrough
		}
		data.expression_operator_type.is_not_null {
			fallthrough
		}
		data.expression_operator_type.like {
			fallthrough
		}
		data.expression_operator_type.like_exact_match {
			fallthrough
		}
		data.expression_operator_type.not_like {
			fallthrough
		}
		data.expression_operator_type.not_like_exact_match {
			return leftValueType, unsafe { nil }
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression operator type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_arithmetic_operation_value_type(leftValueType_1 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match leftValueType_1 {
		data.expression_value_type.boolean {
			return eote.derive_arithmetic_operation_value_type_from_boolean(right_value_type)
		}
		data.expression_value_type.int32 {
			return eote.derive_arithmetic_operation_value_type_from_int32(right_value_type)
		}
		data.expression_value_type.int64 {
			return eote.derive_arithmetic_operation_value_type_from_int64(right_value_type)
		}
		data.expression_value_type.decimal {
			return eote.derive_arithmetic_operation_value_type_from_decimal(right_value_type)
		}
		data.expression_value_type.double {
			return eote.derive_arithmetic_operation_value_type_from_double(right_value_type)
		}
		data.expression_value_type.string {
			if eote == data.expression_operator_type.add {
				return data.expression_value_type.string, unsafe { nil }
			}
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "' + leftValueType_1.string() + '" and "' +
				right_value_type.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_arithmetic_operation_value_type_from_boolean(rightValueType ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType {
		data.expression_value_type.boolean {
			return data.expression_value_type.boolean, unsafe { nil }
		}
		data.expression_value_type.int32 {
			return data.expression_value_type.int32, unsafe { nil }
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.string {
			if eote == data.expression_operator_type.add {
				return data.expression_value_type.string, unsafe { nil }
			}
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Boolean" and "' + rightValueType.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_arithmetic_operation_value_type_from_int32(rightValueType_1 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_1 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			return data.expression_value_type.int32, unsafe { nil }
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.string {
			if eote == data.expression_operator_type.add {
				return data.expression_value_type.string, unsafe { nil }
			}
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Int32" and "' + rightValueType_1.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_arithmetic_operation_value_type_from_int64(rightValueType_2 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_2 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.string {
			if eote == data.expression_operator_type.add {
				return data.expression_value_type.string, unsafe { nil }
			}
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Int64" and "' + rightValueType_2.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_arithmetic_operation_value_type_from_decimal(rightValueType_3 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_3 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			fallthrough
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.string {
			if eote == data.expression_operator_type.add {
				return data.expression_value_type.string, unsafe { nil }
			}
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Decimal" and "' + rightValueType_3.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_arithmetic_operation_value_type_from_double(rightValueType_4 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_4 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			fallthrough
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.string {
			if eote == data.expression_operator_type.add {
				return data.expression_value_type.string, unsafe { nil }
			}
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Double" and "' + rightValueType_4.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_integer_operation_value_type(leftValueType_2 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match leftValueType_2 {
		data.expression_value_type.boolean {
			return eote.derive_integer_operation_value_type_from_boolean(rightValueType_4)
		}
		data.expression_value_type.int32 {
			return eote.derive_integer_operation_value_type_from_int32(rightValueType_4)
		}
		data.expression_value_type.int64 {
			return eote.derive_integer_operation_value_type_from_int64(rightValueType_4)
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.string {
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "' + leftValueType_2.string() + '" and "' +
				rightValueType_4.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_integer_operation_value_type_from_boolean(rightValueType_5 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_5 {
		data.expression_value_type.boolean {
			return data.expression_value_type.boolean, unsafe { nil }
		}
		data.expression_value_type.int32 {
			return data.expression_value_type.int32, unsafe { nil }
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.string {
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Boolean" and "' + rightValueType_5.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_integer_operation_value_type_from_int32(rightValueType_6 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_6 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			return data.expression_value_type.int32, unsafe { nil }
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.string {
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Int32" and "' + rightValueType_6.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_integer_operation_value_type_from_int64(rightValueType_7 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_7 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.string {
			fallthrough
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Int64" and "' + rightValueType_7.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type(leftValueType_3 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match leftValueType_3 {
		data.expression_value_type.boolean {
			return eote.derive_comparison_operation_value_type_from_boolean(rightValueType_7)
		}
		data.expression_value_type.int32 {
			return eote.derive_comparison_operation_value_type_from_int32(rightValueType_7)
		}
		data.expression_value_type.int64 {
			return eote.derive_comparison_operation_value_type_from_int64(rightValueType_7)
		}
		data.expression_value_type.decimal {
			return eote.derive_comparison_operation_value_type_from_decimal(rightValueType_7)
		}
		data.expression_value_type.double {
			return eote.derive_comparison_operation_value_type_from_double(rightValueType_7)
		}
		data.expression_value_type.string {
			return leftValueType_3, unsafe { nil }
		}
		data.expression_value_type.guid {
			return eote.derive_comparison_operation_value_type_from_guid(rightValueType_7)
		}
		data.expression_value_type.date_time {
			return eote.derive_comparison_operation_value_type_from_date_time(rightValueType_7)
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_boolean(rightValueType_8 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_8 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.string {
			return data.expression_value_type.boolean, unsafe { nil }
		}
		data.expression_value_type.int32 {
			return data.expression_value_type.int32, unsafe { nil }
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Boolean" and "' + rightValueType_8.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_int32(rightValueType_9 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_9 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			return data.expression_value_type.int32, unsafe { nil }
		}
		data.expression_value_type.string {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Int32" and "' + rightValueType_9.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_int64(rightValueType_10 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_10 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			return data.expression_value_type.int64, unsafe { nil }
		}
		data.expression_value_type.string {
			fallthrough
		}
		data.expression_value_type.decimal {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Int64" and "' + rightValueType_10.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_decimal(rightValueType_11 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_11 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			fallthrough
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.string {
			return data.expression_value_type.decimal, unsafe { nil }
		}
		data.expression_value_type.double {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Decimal" and "' + rightValueType_11.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_double(rightValueType_12 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_12 {
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			fallthrough
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.string {
			return data.expression_value_type.double, unsafe { nil }
		}
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Double" and "' + rightValueType_12.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_guid(rightValueType_13 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_13 {
		data.expression_value_type.guid {
			fallthrough
		}
		data.expression_value_type.string {
			return data.expression_value_type.guid, unsafe { nil }
		}
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			fallthrough
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.date_time {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "Guid" and "' + rightValueType_13.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_comparison_operation_value_type_from_date_time(rightValueType_14 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	match rightValueType_14 {
		data.expression_value_type.date_time {
			fallthrough
		}
		data.expression_value_type.string {
			return data.expression_value_type.date_time, unsafe { nil }
		}
		data.expression_value_type.boolean {
			fallthrough
		}
		data.expression_value_type.int32 {
			fallthrough
		}
		data.expression_value_type.int64 {
			fallthrough
		}
		data.expression_value_type.decimal {
			fallthrough
		}
		data.expression_value_type.double {
			fallthrough
		}
		data.expression_value_type.guid {
			return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
				'" operation on "DateTime" and "' + rightValueType_14.string() + '"')
		}
		else {
			return data.zero_expression_value_type, errors.new('unexpected expression value type encountered')
		}
	}
}

fn (mut eote ExpressionOperatorTypeEnum) derive_boolean_operation_value_type(leftValueType_4 ExpressionValueTypeEnum) (ExpressionValueTypeEnum, error) {
	if leftValueType_4 == data.expression_value_type.boolean
		&& rightValueType_14 == data.expression_value_type.boolean {
		return data.expression_value_type.boolean, unsafe { nil }
	}
	return data.zero_expression_value_type, errors.new('cannot perform "' + eote.string() +
		'" operation on "' + leftValueType_4.string() + '" and "' + rightValueType_14.string() + '"')
}
