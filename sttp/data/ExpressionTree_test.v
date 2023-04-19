module data

import math
import strconv
import strings
import time
import github.com.araddon.dateparse
import github.com.shopspring.decimal
import github.com.sttp.goapi.sttp.guid
import github.com.sttp.goapi.sttp.xml

fn test_evaluate_boolean_literal_expression(t &testing.T, b bool) {
	mut result, err := evaluate_expression(strconv.format_bool(b), false)
	if err != unsafe { nil } {
		t.fatal('TestEvaluateBooleanLiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t.fatal('TestEvaluateBooleanLiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.boolean {
		t.fatal('TestEvaluateBooleanLiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.boolean_value()
	if err_1 != unsafe { nil } {
		t.fatal('TestEvaluateBooleanLiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if ve != b {
		t.fatal('TestEvaluateBooleanLiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_boolean_literal_expression_1(t_1 &testing.T) {
	test_evaluate_boolean_literal_expression(t_1, false)
	test_evaluate_boolean_literal_expression(t_1, true)
}

fn test_evaluate_int32_literal_expression(t_2 &testing.T, i32 i32) {
	mut result, err := evaluate_expression(strconv.format_int(i64(i32), 10), false)
	if err != unsafe { nil } {
		t_2.fatal('TestEvaluateInt32LiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_2.fatal('TestEvaluateInt32LiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.int32 {
		t_2.fatal('TestEvaluateInt32LiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.int32_value()
	if err_1 != unsafe { nil } {
		t_2.fatal('TestEvaluateInt32LiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if ve != i32 {
		t_2.fatal('TestEvaluateInt32LiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_int32_literal_expression_1(t_3 &testing.T) {
	test_evaluate_int32_literal_expression(t_3, math.min_int32 + 1)
	test_evaluate_int32_literal_expression(t_3, -1)
	test_evaluate_int32_literal_expression(t_3, 0)
	test_evaluate_int32_literal_expression(t_3, 1)
	test_evaluate_int32_literal_expression(t_3, math.max_int32)
}

fn test_evaluate_int64_literal_expression(t_4 &testing.T, i64 i64) {
	mut result, err := evaluate_expression(strconv.format_int(i64, 10), false)
	if err != unsafe { nil } {
		t_4.fatal('TestEvaluateInt64LiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_4.fatal('TestEvaluateInt64LiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.int64 {
		t_4.fatal('TestEvaluateInt64LiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.int64_value()
	if err_1 != unsafe { nil } {
		t_4.fatal('TestEvaluateInt64LiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if ve != i64 {
		t_4.fatal('TestEvaluateInt64LiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_int64_literal_expression_1(t_5 &testing.T) {
	test_evaluate_int64_literal_expression(t_5, math.min_int64 + 1)
	test_evaluate_int64_literal_expression(t_5, math.min_int32)
	test_evaluate_int64_literal_expression(t_5, math.max_int32 + 1)
	test_evaluate_int64_literal_expression(t_5, math.max_int64)
}

pub fn test_evaluate_decimal_literal_expression(t_6 &testing.T) {
	mut dec := string('-9223372036854775809.87686876')
	mut d := decimal.Decimal{}
	d, _ = decimal.new_from_string(dec)
	mut result, err := evaluate_expression(dec, false)
	if err != unsafe { nil } {
		t_6.fatal('TestEvaluateDecimalLiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_6.fatal('TestEvaluateDecimalLiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.decimal {
		t_6.fatal('TestEvaluateDecimalLiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.decimal_value()
	if err_1 != unsafe { nil } {
		t_6.fatal('TestEvaluateDecimalLiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if !ve.equal(d) {
		t_6.fatal('TestEvaluateDecimalLiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_double_literal_expression(t_7 &testing.T) {
	mut d := f64(123.456e-6)
	mut result, err := evaluate_expression('123.456E-6', false)
	if err != unsafe { nil } {
		t_7.fatal('TestEvaluateDoubleLiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_7.fatal('TestEvaluateDoubleLiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.double {
		t_7.fatal('TestEvaluateDoubleLiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.double_value()
	if err_1 != unsafe { nil } {
		t_7.fatal('TestEvaluateDoubleLiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if ve != d {
		t_7.fatal('TestEvaluateDoubleLiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_string_literal_expression(t_8 &testing.T) {
	mut s := "'Hello, literal string expression'"
	mut result, err := evaluate_expression(s, false)
	if err != unsafe { nil } {
		t_8.fatal('TestEvaluateStringLiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_8.fatal('TestEvaluateStringLiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.string {
		t_8.fatal('TestEvaluateStringLiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.string_value()
	if err_1 != unsafe { nil } {
		t_8.fatal('TestEvaluateStringLiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if ve != s[1..s.len - 1] {
		t_8.fatal('TestEvaluateStringLiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_guid_literal_expression(t_9 &testing.T) {
	mut g := guid.new()
	mut result, err := evaluate_expression(g.string(), false)
	if err != unsafe { nil } {
		t_9.fatal('TestEvaluateGuidLiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_9.fatal('TestEvaluateGuidLiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.guid {
		t_9.fatal('TestEvaluateGuidLiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.guid_value()
	if err_1 != unsafe { nil } {
		t_9.fatal('TestEvaluateGuidLiteralExpression: failed to retrieve value: ' + err_1.error())
	}
	if !ve.equal(g) {
		t_9.fatal('TestEvaluateGuidLiteralExpression: retrieved value does not match source')
	}
}

fn test_date_time(t_11 &testing.T, dt_1 time.Time, sr_1 string) {
	mut result, err := evaluate_expression('#' + sr_1 + '#', false)
	if err != unsafe { nil } {
		t_11.fatal('TestEvaluateDateTimeLiteralExpression: error parsing expression: ' + err.error())
	}
	if result == unsafe { nil } {
		t_11.fatal('TestEvaluateDateTimeLiteralExpression: received no result')
	}
	if result.value_type() != expression_value_type.date_time {
		t_11.fatal('TestEvaluateDateTimeLiteralExpression: received unexpected type: ' +
			result.value_type.string())
	}
	mut ve, err_1 := result.date_time_value()
	if err_1 != unsafe { nil } {
		t_11.fatal('TestEvaluateDateTimeLiteralExpression: failed to retrieve value: ' +
			err_1.error())
	}
	if !ve.equal(dt_1) {
		t_11.fatal('TestEvaluateDateTimeLiteralExpression: retrieved value does not match source')
	}
}

pub fn test_evaluate_date_time_literal_expression(t_10 &testing.T) {
	mut sr := '2006-01-01 00:00:00'
	mut dt, _ := dateparse.parse_any(sr)
	test_date_time(t_10, dt, sr)
	sr_1 = '2019-01-1 00:00:59.999'
	dt_1, _ = dateparse.parse_any(sr_1)
	test_date_time(t_11, dt_1, sr_1)
	dt_1 = time.now()
	test_date_time(t_11, dt_1, dt_1.format(time.rfc3339_nano))
	dt_1 = time.now.utc()
	test_date_time(t_11, dt_1, dt_1.format(time.rfc3339_nano))
}

// gocyclo: ig
pub fn test_signal_idset_expressions(t_11 &testing.T) {
	mut data_set, _, _, stat_id, freq_id := create_data_set()
	mut id_set, err := select_signal_idset(data_set, "FILTER ActiveMeasurements WHERE SignalType = 'FREQ'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 1 {
		t_11.fatal('TestSignalIDSetExpressions: expected 1 result, received: ' +
			strconv.itoa(id_set.len))
	}
	if id_set.keys[0] != freq_id {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, "FILTER ActiveMeasurements WHERE SignalType = 'STAT'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 1 {
		t_11.fatal('TestSignalIDSetExpressions: expected 1 result, received: ' +
			strconv.itoa(id_set.len))
	}
	if id_set.keys[0] != stat_id {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, stat_id.string(), 'ActiveMeasurements',
		unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 1 {
		t_11.fatal('TestSignalIDSetExpressions: expected 1 result, received: ' +
			strconv.itoa(id_set.len))
	}
	if id_set.keys[0] != stat_id {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, ';;' + stat_id.string() + ';;;', 'ActiveMeasurements',
		unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 1 {
		t_11.fatal('TestSignalIDSetExpressions: expected 1 result, received: ' +
			strconv.itoa(id_set.len))
	}
	if id_set.keys[0] != stat_id {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	mut freq_uuid := freq_id.string()
	id_set, err = select_signal_idset(data_set, "'" + freq_uuid[1..freq_uuid.len - 1] + "'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 1 {
		t_11.fatal('TestSignalIDSetExpressions: expected 1 result, received: ' +
			strconv.itoa(id_set.len))
	}
	if id_set.keys[0] != freq_id {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, strconv.v_sprintf('%s;%s;%s', stat_id.string(),
		freq_id.string(), stat_id.string()), 'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 2 {
		t_11.fatal('TestSignalIDSetExpressions: expected 2 results, received: ' +
			strconv.itoa(id_set.len))
	}
	if !id_set.contains(stat_id) || !id_set.contains(freq_id) {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, strconv.v_sprintf('%s;%s;%s;FILTER ActiveMeasurements WHERE True',
		stat_id.string(), freq_id.string(), stat_id.string()), 'ActiveMeasurements', unsafe { nil },
		false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 2 {
		t_11.fatal('TestSignalIDSetExpressions: expected 2 results, received: ' +
			strconv.itoa(id_set.len))
	}
	if !id_set.contains(stat_id) || !id_set.contains(freq_id) {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, "FILTER ActiveMeasurements WHERE SignalID = '" +
		freq_uuid[1..freq_uuid.len - 1] + "'", 'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 1 {
		t_11.fatal('TestSignalIDSetExpressions: expected 1 result, received: ' +
			strconv.itoa(id_set.len))
	}
	if id_set.keys[0] != freq_id {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	id_set, err = select_signal_idset(data_set, "FILTER ActiveMeasurements WHERE SignalID = '" +
		freq_uuid[1..freq_uuid.len - 1] + "' OR SignalID = " + stat_id.string(), 'ActiveMeasurements',
		unsafe { nil }, false)
	if err != unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error executing SelectSignalIDSet: ' + err.error())
	}
	if id_set.len != 2 {
		t_11.fatal('TestSignalIDSetExpressions: expected 2 results, received: ' +
			strconv.itoa(id_set.len))
	}
	if !id_set.contains(stat_id) || !id_set.contains(freq_id) {
		t_11.fatal('TestSignalIDSetExpressions: retrieve Guid value does not match source')
	}
	_, err = select_signal_idset(data_set, '', '', unsafe { nil }, false)
	if err == unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error expected, received none')
	}
	_, err = select_signal_idset(data_set, 'bad expression', 'ActiveMeasurements', unsafe { nil },
		false)
	if err == unsafe { nil } {
		t_11.fatal('TestSignalIDSetExpressions: error expected, received none')
	}
}

fn get_row_string(t_13 &testing.T, row &DataRow, columnIndex int) string {
	mut value, null, err_1 := row.string_value(columnIndex)
	if null || err_1 != unsafe { nil } {
		t_13.fatal('TestSelectDataRowsExpressions: failed to retrieve string value')
	}
	return value
}

// gocyclo: ig
pub fn test_select_data_rows_expressions(t_12 &testing.T) {
	mut data_set, signal_idfield, signal_type_field, stat_id, freq_id := create_data_set()
	mut rows, err := select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType = 'FREQ'; FILTER ActiveMeasurements WHERE SignalType = 'STAT' ORDER BY SignalID",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(freq_id) || !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType = 'FREQ' OR SignalType = 'STAT'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType = 'FREQ' OR SignalType = 'STAT' ORDER BY BINARY SignalType",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(freq_id) || !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType = 'STAT' OR SignalType = 'FREQ' ORDER BY SignalType DESC",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	mut freq_uuid := freq_id.string()
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE SignalID = ' +
		stat_id.string() + " OR SignalID = '" + freq_uuid[1..freq_uuid.len - 1] +
		"' ORDER BY SignalType", 'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(freq_id) || !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE SignalID = ' +
		stat_id.string() + " OR SignalID = '" + freq_uuid[1..freq_uuid.len - 1] +
		"' ORDER BY SignalType;" + stat_id.string(), 'ActiveMeasurements', unsafe { nil },
		false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE True', 'ActiveMeasurements',
		unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE IsNull(NULL, False) OR Coalesce(Null, true)',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE IIf(IsNull(NULL, False) OR Coalesce(Null, true), Len(SignalType) == 4, false)',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE SignalType IS !NULL',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE Len(SubStr(Coalesce(Trim(SignalType), 'OTHER'), 0, 0X2)) = 2",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE LEN(SignalTYPE) > 3.5',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE Len(SignalType) & 0x4 == 4',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE RegExVal('ST.+', SignalType) == 'STAT'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 1 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 1 result, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE RegExMatch('FR.+', SignalType)",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 1 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 1 result, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType IN ('FREQ', 'STAT') ORDER BY SignalType",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(freq_id) || !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE SignalID IN (' +
		stat_id.string() + ', ' + freq_id.string() + ')', 'ActiveMeasurements', unsafe { nil },
		false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType LIKE 'ST%'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 1 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 1 result, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType LIKE '*EQ'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 1 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 1 result, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, "FILTER ActiveMeasurements WHERE SignalType LIKE '*TA%'",
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 1 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 1 result, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE -Len(SignalType) <= 0',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE SignalType == 0',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 0 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 0 results, received: ' +
			strconv.itoa(rows.len))
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE SignalType > 99',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	rows, err = select_data_rows(data_set, 'FILTER ActiveMeasurements WHERE Len(SignalType) / 0x2 = 2',
		'ActiveMeasurements', unsafe { nil }, false)
	if err != unsafe { nil } {
		t_12.fatal('TestSelectDataRowsExpressions: error executing SelectDataRows: ' + err.error())
	}
	if rows.len != 2 {
		t_12.fatal('TestSelectDataRowsExpressions: expected 2 results, received: ' +
			strconv.itoa(rows.len))
	}
	if !get_row_guid.equal(stat_id) || !get_row_guid.equal(freq_id) {
		t_12.fatal('TestSelectDataRowsExpressions: retrieve Guid value or order does not match source')
	}
	if get_row_string(t_12, rows[0], signal_type_field) != 'STAT'
		|| get_row_string(t_13, rows[1], signal_type_field) != 'FREQ' {
		t_13.fatal('TestSelectDataRowsExpressions: retrieve string value or order does not match source')
	}
}

// gocyclo: ig
pub fn test_metadata_expressions(t_13 &testing.T) {
	for i := 0; i < 2; i++ {
		mut file_name := strconv.v_sprintf('../../test/MetadataSample%d.xml', i + 1)
		mut doc := xml.XmlDocument{}
		mut err := doc.load_xml_from_file(file_name)
		if err != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error loading XML document: ' + err.error())
		}
		mut data_set := new_data_set()
		err = data_set.parse_xml_document(&doc)
		if err != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error loading DataSet from XML document: ' +
				err.error())
		}
		if data_set.table_count() != 4 {
			t_13.fatal('TestMetadataExpressions: expected 4 results, received: ' +
				strconv.itoa(data_set.table_count()))
		}
		mut table := data_set.table('MeasurementDetail')
		if table == unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: table not found in DataSet')
		}
		if table.column_count() != 11 {
			t_13.fatal('TestMetadataExpressions: expected table column count: ' +
				strconv.itoa(table.column_count()))
		}
		if table.column_by_name('ID') == unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: missing expected table column')
		}
		if table.column_by_name.@type() != data_type.string {
			t_13.fatal('TestMetadataExpressions: unexpected table column type')
		}
		if table.column_by_name('SignalID') == unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: missing expected table column')
		}
		if table.column_by_name.@type() != data_type.guid {
			t_13.fatal('TestMetadataExpressions: unexpected table column type')
		}
		if table.row_count() == 0 {
			t_13.fatal('TestMetadataExpressions: unexpected empty table')
		}
		table = data_set.table('DeviceDetail')
		if table == unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: table not found in DataSet')
		}
		if table.column_count() != 19 + i {
			t_13.fatal('TestMetadataExpressions: expected table column count: ' +
				strconv.itoa(table.column_count()))
		}
		if table.column_by_name('ACRONYM') == unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: missing expected table column')
		}
		if table.column_by_name.@type() != data_type.string {
			t_13.fatal('TestMetadataExpressions: unexpected table column type')
		}
		if table.column_by_name('Name') == unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: missing expected table column')
		}
		if table.column_by_name.@type() != data_type.string {
			t_13.fatal('TestMetadataExpressions: unexpected table column type')
		}
		if table.row_count() != 1 {
			t_13.fatal('TestMetadataExpressions: expected table row count: ' +
				strconv.itoa(table.row_count()))
		}
		mut data_row := table.row(0)
		mut acronym, null, err_1 := data_row.string_value_by_name('Acronym')
		if null || err_1 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: unexpected NULL column value in row')
		}
		mut name, null_1, err_2 := data_row.string_value_by_name('Name')
		if null_1 || err_2 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: unexpected NULL column value in row')
		}
		if !strings.equal_fold(acronym, name) {
			t_13.fatal('TestMetadataExpressions: unexpected column values in row')
		}
		_, null_1, _ = data_row.string_value_by_name('OriginalSource')
		if !null_1 {
			t_13.fatal('TestMetadataExpressions: unexpected column value in row')
		}
		mut parent_acronym, null_2, _ := data_row.string_value_by_name('ParentAcronym')
		if parent_acronym.len > 0 || null_2 {
			t_13.fatal('TestMetadataExpressions: unexpected column value in row')
		}
		mut id_set, err_3 := select_signal_idset(data_set, "FILTER MeasurementDetail WHERE SignalAcronym = 'FREQ'",
			'MeasurementDetail', unsafe { nil }, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER TOP 8 MeasurementDetail WHERE SignalAcronym = 'STAT'",
			'MeasurementDetail', unsafe { nil }, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 8 {
			t_13.fatal('TestMetadataExpressions: expected 8 results, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER TOP 0 MeasurementDetail WHERE SignalAcronym = 'STAT'",
			'MeasurementDetail', unsafe { nil }, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 0 {
			t_13.fatal('TestMetadataExpressions: expected 0 results, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER TOP -1 MeasurementDetail WHERE SignalAcronym = 'STAT'",
			'MeasurementDetail', unsafe { nil }, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len == 0 {
			t_13.fatal('TestMetadataExpressions: expected non-zero result set, received: ' +
				strconv.itoa(id_set.len))
		}
		mut device_detail_idfields := new(table_idfields)
		device_detail_idfields.signal_idfield_name = 'UniqueID'
		device_detail_idfields.measurement_key_field_name = 'Name'
		device_detail_idfields.point_tag_field_name = 'Acronym'
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Convert(Longitude, 'System.Int32') = -89",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Convert(latitude, 'int16') = 35",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Convert(latitude, 'Int32') = 35",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Convert(Convert(Latitude, 'Int32'), 'String') = 35",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Convert(Latitude, 'Single') > 35",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, 'FILTER DeviceDetail WHERE Longitude < 0.0',
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Acronym IN ('Test', 'Shelby')",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE Acronym not IN ('Test', 'Apple')",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE NOT (Acronym IN ('Test', 'Apple'))",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		id_set, err_3 = select_signal_idset(data_set, "FILTER DeviceDetail WHERE NOT Acronym !IN ('Shelby', 'Apple')",
			'DeviceDetail', device_detail_idfields, false)
		if err_3 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectSignalIDSet: ' +
				err_3.error())
		}
		if id_set.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(id_set.len))
		}
		mut rows, err_4 := select_data_rows(data_set, "Acronym LIKE 'Shel%'", 'DeviceDetail',
			device_detail_idfields, false)
		if err_4 != unsafe { nil } {
			t_13.fatal('TestMetadataExpressions: error executing SelectDataRows: ' + err_4.error())
		}
		if rows.len != 1 {
			t_13.fatal('TestMetadataExpressions: expected 1 result, received: ' +
				strconv.itoa(rows.len))
		}
	}
}

// gocyclo: ig
pub fn test_basic_expressions(t_14 &testing.T) {
	mut doc := xml.XmlDocument{}
	mut err := doc.load_xml_from_file('../../test/MetadataSample2.xml')
	if err != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error loading XML document: ' + err.error())
	}
	mut data_set := new_data_set()
	err = data_set.parse_xml_document(&doc)
	if err != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error loading DataSet from XML document: ' + err.error())
	}
	mut data_rows, err_1 := data_set.table.@select("SignalAcronym = 'STAT'", '', -1)
	if err_1 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during table Select: ' + err_1.error())
	}
	if data_rows.len != 116 {
		t_14.fatal('TestBasicExpressions: expected 116 results, received: ' +
			strconv.itoa(data_rows.len))
	}
	data_rows, err_1 = data_set.table.@select("Type = 'V'", '', -1)
	if err_1 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during table Select: ' + err_1.error())
	}
	if data_rows.len != 2 {
		t_14.fatal('TestBasicExpressions: expected 2 results, received: ' +
			strconv.itoa(data_rows.len))
	}
	mut value_expression, err_2 := evaluate_data_row_expression(data_set.table.row(0),
		'VersionNumber > 0', false)
	if err_2 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_2.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut result, err_3 := value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	mut data_row := data_set.table.row(0)
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'AccessID % 2 = 0 AND FramesPerSecond % 4 <> 2 OR AccessID % 1 = 0',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'AccessID % 2 = 0 AND (FramesPerSecond % 4 <> 2 OR -AccessID % 1 = 0)',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'AccessID % 2 = 0 AND (FramesPerSecond % 4 <> 2 AND AccessID % 1 = 0)',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'AccessID % 2 >= 0 || (FramesPerSecond % 4 <> 2 AND AccessID % 1 = 0)',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'AccessID % 2 = 0 OR FramesPerSecond % 4 != 2 && AccessID % 1 == 0',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, '!AccessID % 2 = 0 || FramesPerSecond % 4 = 0x2 && AccessID % 1 == 0',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'NOT AccessID % 2 = 0 OR FramesPerSecond % 4 >> 0x1 = 1 && AccessID % 1 == 0x0',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, '!AccessID % 2 = 0 OR FramesPerSecond % 4 >> 1 = 1 && AccessID % 3 << 1 & 4 >= 4',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'OriginalSource IS NULL',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'ParentAcronym IS NOT NULL',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'NOT ParentAcronym IS NULL && Len(parentAcronym) == 0',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_3 = value_expression.boolean_value()
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_3.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, '-FramesPerSecond',
		false)
	if err_3 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut value, err_4 := value_expression.int32_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if value != -30 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, '~FramesPerSecond',
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	value, err_4 = value_expression.int32_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if value != -31 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, '~FramesPerSecond * -1 - 1 << -2',
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	value, err_4 = value_expression.int32_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if value != -2147483648 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, 'NOT True', false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, '!True', false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, '~True', false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, "Len(IsNull(OriginalSource, 'A')) = 1",
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, "RegExMatch('SH', Acronym)",
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, "RegExMatch('SH', Name)",
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, "RegExMatch('S[hH]', Name) && RegExMatch('S[hH]', Acronym)",
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_4 = value_expression.boolean_value()
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_4.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_4 = evaluate_data_row_expression(data_row, "RegExVal('Sh\\w+', Name)",
		false)
	if err_4 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_4.error())
	}
	if value_expression.value_type() != expression_value_type.string {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut s, err_5 := value_expression.string_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if s != 'Shelby' {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "SubStr(RegExVal('Sh\\w+', Name), 2) == 'ElbY'",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "SubStr(RegExVal('Sh\\w+', Name), 3, 2) == 'lB'",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "RegExVal('Sh\\w+', Name) IN ('NT', Acronym, 'NT')",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "RegExVal('Sh\\w+', Name) IN ===('NT', Acronym, 'NT')",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "RegExVal('Sh\\w+', Name) IN BINARY ('NT', Acronym, 3.05)",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "Name IN===(0x9F, Acronym, 'Shelby')",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "Acronym LIKE === 'Sh*'",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "name LiKe binaRY 'SH%'",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, "Name === 'Shelby' && Name== 'SHelBy' && Name !=='SHelBy'",
		false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_5 = value_expression.boolean_value()
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_5.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_5 = evaluate_data_row_expression(data_row, 'Now()', false)
	if err_5 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_5.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut dt, err_6 := value_expression.date_time_value()
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_6.error())
	}
	mut now := time.now()
	if dt != now && !dt.before(now) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_6 = evaluate_data_row_expression(data_row, 'UtcNow()', false)
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_6.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_6 = value_expression.date_time_value()
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_6.error())
	}
	now = time.now.utc()
	if dt != now && !dt.before(now) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_6 = evaluate_data_row_expression(data_row, '#2019-02-04T03:00:52.73-05:00#',
		false)
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_6.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_6 = value_expression.date_time_value()
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_6.error())
	}
	if dt.month() != 2 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_6 = evaluate_data_row_expression(data_row, '#2019-02-04T03:00:52.73-05:00#',
		false)
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_6.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_6 = value_expression.date_time_value()
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_6.error())
	}
	if dt.day() != 4 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_6 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04T03:00:52.73-05:00#, 'Year')",
		false)
	if err_6 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_6.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut i32_1, err_7 := value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 2019 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019/02/04 03:00:52.73-05:00#, 'Month')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 2 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04 03:00:52.73-05:00#, 'Day')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 4 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04 03:00#, 'Hour')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 3 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04 03:00:52.73-05:00#, 'Hour')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 8 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2/4/2019 3:21:55#, 'Minute')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 21 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#02/04/2019 03:21:55.33#, 'Second')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 55 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#02/04/2019 03:21:5.033#, 'Millisecond')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 33 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(DateAdd('2019-02-04 03:00:52.73-05:00', 1, 'Year'), 'year')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 2020 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd('2019-02-04', 2, 'Month')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 4, 4, 0, 0, 0, 0, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd(#1/31/2019#, 1, 'Day')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 2, 1, 0, 0, 0, 0, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd(#2019-01-31#, 2, 'Week')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 2, 14, 0, 0, 0, 0, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd(#2019-01-31#, 25, 'Hour')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 2, 1, 1, 0, 0, 0, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd(#2018-12-31 23:58#, 3, 'Minute')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 1, 1, 0, 1, 0, 0, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd('2019-01-1 00:59', 61, 'Second')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 1, 1, 1, 0, 1, 0, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd('2019-01-1 00:00:59.999', 2, 'Millisecond')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 1, 1, 0, 1, 0, 1000000, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateAdd(#1/1/2019 0:0:1.029#, -FramesPerSecond, 'Millisecond')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.date_time {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	dt, err_7 = value_expression.date_time_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !dt.equal(time.date(2019, 1, 1, 0, 0, 0, 999000000, time.utc)) {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'Year')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 2 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'month')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 35 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'DAY')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 1095 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'Week')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 156 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'WeekDay')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 1095 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'Hour')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 26280 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'Minute')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 1576800 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2006-01-01 00:00:00#, #2008-12-31 00:00:00#, 'Second')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 94608000 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DateDiff(#2008-12-30 00:02:50.546#, '2008-12-31', 'Millisecond')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 86229454 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04 03:00:52.73-05:00#, 'DayOfyear')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 35 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04 03:00:52.73-05:00#, 'Week')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 6 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "DatePart(#2019-02-04 03:00:52.73-05:00#, 'WeekDay')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_7 = value_expression.int32_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if i32_1 != 2 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "IsDate(#2019-02-04 03:00:52.73-05:00#) AND IsDate('2/4/2019') ANd isdate(updatedon) && !ISDATE(2.5) && !IsDate('ImNotADate')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_7 = value_expression.boolean_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "IsInteger(32768) AND IsInteger('1024') and ISinTegeR(FaLsE) And isinteger(accessID) && !ISINTEGER(2.5) && !IsInteger('ImNotAnInteger')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_7 = value_expression.boolean_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "IsGuid({9448a8b5-35c1-4dc7-8c42-8712153ac08a}) AND IsGuid('9448a8b5-35c1-4dc7-8c42-8712153ac08a') anD isGuid(9448a8b5-35c1-4dc7-8c42-8712153ac08a) AND IsGuid(Convert(9448a8b5-35c1-4dc7-8c42-8712153ac08a, 'string')) aND isguid(nodeID) && !ISGUID(2.5) && !IsGuid('ImNotAGuid')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_7 = value_expression.boolean_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "IsNumeric(32768) && isNumeric(123.456e-67) AND IsNumeric(3.14159265) and ISnumeric(true) AND IsNumeric('1024' ) and IsNumeric(2.5) aNd isnumeric(longitude) && !ISNUMERIC(9448a8b5-35c1-4dc7-8c42-8712153ac08a) && !IsNumeric('ImNotNumeric')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	if value_expression.value_type() != expression_value_type.boolean {
		t_14.fatal('TestBasicExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	result, err_7 = value_expression.boolean_value()
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_7.error())
	}
	if !result {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_7 = evaluate_data_row_expression(data_row, "Convert(maxof(12, '99.9', 99.99), 'Double')",
		false)
	if err_7 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_7.error())
	}
	mut f64, err_8 := value_expression.double_value()
	if err_8 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_8.error())
	}
	if f64 != 99.99 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
	value_expression, err_8 = evaluate_data_row_expression(data_row, "Convert(minof(12, '99.9', 99.99), 'double')",
		false)
	if err_8 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error during EvaluateDataRowExpression: ' + err_8.error())
	}
	f64, err_8 = value_expression.double_value()
	if err_8 != unsafe { nil } {
		t_14.fatal('TestBasicExpressions: error getting value: ' + err_8.error())
	}
	if f64 != 12.0 {
		t_14.fatal('TestBasicExpressions: unexpected value expression result')
	}
}

pub fn test_negative_expressions(t_15 &testing.T) {
	_, err := evaluate_expression("Convert(123, 'unknown')", false)
	if err == unsafe { nil } {
		t_15.fatal('TestNegativeExpressions: expected error during EvaluateDataRowExpression')
	}
	_, err = evaluate_expression('I am a bad expression', false)
	if err == unsafe { nil } {
		t_15.fatal('TestNegativeExpressions: expected error during EvaluateDataRowExpression')
	}
}

// gocyclo: ig
pub fn test_misc_expressions(t_16 &testing.T) {
	mut doc := xml.XmlDocument{}
	mut err := doc.load_xml_from_file('../../test/MetadataSample2.xml')
	if err != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error loading XML document: ' + err.error())
	}
	mut data_set := new_data_set()
	err = data_set.parse_xml_document(&doc)
	if err != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error loading DataSet from XML document: ' + err.error())
	}
	mut data_row := data_set.table.row(0)
	mut value_expression, err_1 := evaluate_data_row_expression(data_row, 'AccessID ^ 2 + FramesPerSecond XOR 4',
		false)
	if err_1 != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error during EvaluateDataRowExpression: ' + err_1.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_16.fatal('TestMiscExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut i32_1, err_2 := value_expression.int32_value()
	if err_2 != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error getting value: ' + err_2.error())
	}
	if i32_1 != 38 {
		t_16.fatal('TestMiscExpressions: unexpected value expression result')
	}
	mut g := guid.new()
	value_expression, err_2 = evaluate_data_row_expression(data_row, g.string(), false)
	if err_2 != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error during EvaluateDataRowExpression: ' + err_2.error())
	}
	if value_expression.value_type() != expression_value_type.guid {
		t_16.fatal('TestMiscExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	mut ge, err_3 := value_expression.guid_value()
	if err_3 != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error getting value: ' + err_3.error())
	}
	if !g.equal(ge) {
		t_16.fatal('TestMiscExpressions: unexpected value expression result')
	}
	value_expression, err_3 = evaluate_data_row_expression(data_row, 'ComputedCol', false)
	if err_3 != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error during EvaluateDataRowExpression: ' + err_3.error())
	}
	if value_expression.value_type() != expression_value_type.int32 {
		t_16.fatal('TestMiscExpressions: unexpected value expression type: ' +
			value_expression.@type.string())
	}
	i32_1, err_3 = value_expression.int32_value()
	if err_3 != unsafe { nil } {
		t_16.fatal('TestMiscExpressions: error getting value: ' + err_3.error())
	}
	if i32_1 != 32 {
		t_16.fatal('TestMiscExpressions: unexpected value expression result')
	}
}

pub fn test_filter_expression_statement_count(t_17 &testing.T) {
	mut data_set, _, _, stat_id, freq_id := create_data_set()
	mut parser, err := new_filter_expression_parser_for_data_set(data_set, strconv.v_sprintf('%s;%s;%s;FILTER ActiveMeasurements WHERE True',
		stat_id.string(), freq_id.string(), stat_id.string()), 'ActiveMeasurements', unsafe { nil },
		false)
	if err != unsafe { nil } {
		t_17.fatal(
			'TestFilterExpressionStatementCount: unexpected NewFilterExpressionParserForDataSet error: ' +
			err.error())
	}
	parser.track_filtered_rows = false
	parser.track_filtered_signal_ids = true
	mut err_1 := parser.evaluate(true, false)
	if err_1 != unsafe { nil } {
		t_17.fatal('TestFilterExpressionStatementCount: unexpected Evaluate error: ' + err_1.error())
	}
	mut id_set := parser.filtered_signal_idset()
	if id_set.len != 2 {
		t_17.fatal('TestFilterExpressionStatementCount: expected 2 results, received: ' +
			strconv.itoa(id_set.len))
	}
	if !id_set.contains(stat_id) || !id_set.contains(freq_id) {
		t_17.fatal('TestFilterExpressionStatementCount: retrieve Guid value does not match source')
	}
	if parser.filter_expression_statement_count() != 4 {
		t_17.fatal('TestFilterExpressionStatementCount: expected 4 results, received: ' +
			strconv.itoa(parser.filter_expression_statement_count()))
	}
}
