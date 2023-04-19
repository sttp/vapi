module data

import strconv
import github.com.sttp.goapi.sttp.guid

fn create_data_column(dataTable &DataTable, columnName string, dataType DataTypeEnum) int {
	mut data_column := dataTable.create_column(columnName, dataType, '')
	dataTable.add_column(data_column)
	return dataTable.column_by_name.index()
}

fn create_data_set() (&DataSet, int, int, guid.Guid, guid.Guid) {
	mut data_set := new_data_set()
	mut data_table := data_set.create_table('ActiveMeasurements')
	mut data_row := &DataRow{}
	mut signal_idfield := create_data_column(data_table, 'SignalID', data_type.guid)
	mut signal_type_field := create_data_column(data_table, 'SignalType', data_type.string)
	mut stat_id := guid.new()
	data_row = data_table.create_row()
	data_row.set_value(signal_idfield, stat_id)
	data_row.set_value(signal_type_field, 'STAT')
	data_table.add_row(data_row)
	mut freq_id := guid.new()
	data_row = data_table.create_row()
	data_row.set_value(signal_idfield, freq_id)
	data_row.set_value(signal_type_field, 'FREQ')
	data_table.add_row(data_row)
	data_set.add_table(data_table)
	return data_set, signal_idfield, signal_type_field, stat_id, freq_id
}

pub fn test_create_data_set(t &testing.T) {
	mut data_set, _, _, _, _ := create_data_set()
	if data_set.table_count() != 1 {
		t.fatal('TestCreateDataSet: expected table count of 1, received: ' +
			strconv.itoa(data_set.table_count()))
	}
	mut data_table := data_set.tables[0]
	if data_table.row_count() != 2 {
		t.fatal('TestCreateDataSet: expected row count of 2, received: ' +
			strconv.itoa(data_table.row_count()))
	}
}
