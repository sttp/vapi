module data

import strings
import github.com.sttp.goapi.sttp.format

struct DataTable {
mut:
	parent         &DataSet
	name           string
	column_indexes map[string]int
	columns        []&DataColumn
	rows           []&DataRow
}

fn new_data_table(parent &DataSet, name string) &DataTable {
	return &DataTable{
		parent: parent
		name: name
		column_indexes: map[string]int{}
	}
}

// Parent gets the parent DataSet of the DataTa
pub fn (mut dt DataTable) parent_1() &DataSet {
	return dt.parent
}

// Name gets the name of the DataTa
pub fn (mut dt DataTable) name_1() string {
	return dt.name
}

// InitColumns initializes the internal column collection to the specified len
pub fn (mut dt DataTable) init_columns(length int) {
	dt.columns = [] * DataColumn{
		len: 0
	}
	dt.column_indexes = {
		len: length
	}
}

// AddColumn adds the specified column to the DataTa
pub fn (mut dt DataTable) add_column(column &DataColumn) {
	column.index = dt.columns.len
	dt.column_indexes[column.name().to_upper()] = column.index
	dt.columns << column
}

// Column gets the DataColumn at the specified columnIndex if the index is in ra
pub fn (mut dt DataTable) column_1(columnIndex int) &DataColumn {
	if columnIndex < 0 || columnIndex >= dt.columns.len {
		return unsafe { nil }
	}
	return dt.columns[columnIndex]
}

// ColumnByName gets the DataColumn for the specified columnName if the name exi
pub fn (mut dt DataTable) column_by_name(columnName string) &DataColumn {
	mut column_index, ok := dt.column_indexes[columnName.to_upper()]
	if ok {
		return dt.column(column_index)
	}
	return unsafe { nil }
}

// ColumnIndex gets the index for the specified columnName if the name exi
pub fn (mut dt DataTable) column_index_1(columnName_1 string) int {
	mut column_3 := dt.column_by_name(columnName_1)
	if column_3 == unsafe { nil } {
		return -1
	}
	return column_3.index()
}

// CreateColumn creates a new DataColumn associated with the DataTa
pub fn (mut dt DataTable) create_column(name_3 string, dataType DataTypeEnum, expression string) &DataColumn {
	return new_data_column(dt, name_3, dataType, expression)
}

// CloneColumn creates a copy of the specified source DataColumn associated with the DataTa
pub fn (mut dt DataTable) clone_column(source &DataColumn) &DataColumn {
	return dt.create_column(source.name(), source.@type(), source.expression())
}

// ColumnCount gets the total number columns defined in the DataTa
pub fn (mut dt DataTable) column_count() int {
	return dt.columns.len
}

// InitRows initializes the internal row collection to the specified len
pub fn (mut dt DataTable) init_rows(length_1 int) {
	dt.rows = [] * DataRow{
		len: 0
	}
}

// AddRow adds the specified row to the DataTa
pub fn (mut dt DataTable) add_row(row &DataRow) {
	dt.rows << row
}

// Row gets the DataRow at the specified rowIndex if the index is in ra
pub fn (mut dt DataTable) row_1(rowIndex int) &DataRow {
	if rowIndex < 0 || rowIndex >= dt.rows.len {
		return unsafe { nil }
	}
	return dt.rows[rowIndex]
}

// RowsWhere returns the rows matching the predicate expression. Set limit param
pub fn (mut dt DataTable) rows_where(predicate fn (&DataRow) bool, limit int) []&DataRow {
	mut matching_rows := [] * DataRow{
		len: 0
	}
	mut count := 0
	for i := 0; i < dt.rows.len; i++ {
		mut data_row := dt.rows[i]
		if data_row == unsafe { nil } {
			continue
		}
		if predicate(data_row) {
			matching_rows << data_row
			count++
			if limit > -1 && count >= limit {
				break
			}
		}
	}
	return matching_rows
}

// CreateRow creates a new DataRow associated with the DataTa
pub fn (mut dt DataTable) create_row() &DataRow {
	return new_data_row(dt)
}

// CloneRow creates a copy of the specified source DataRow associated with the DataTa
pub fn (mut dt DataTable) clone_row(source_1 &DataRow) &DataRow {
	mut row_3 := dt.create_row()
	for i := 0; i < dt.columns.len; i++ {
		mut value, _ := source_1.value(i)
		row_3.set_value(i, value)
	}
	return row_3
}

// RowCount gets the total number of rows defined in the DataTa
pub fn (mut dt DataTable) row_count() int {
	return dt.rows.len
}

// RowValueAsString reads the row record value at the specified columnIndex converted to a str
pub fn (mut dt DataTable) row_value_as_string(rowIndex_1 int) string {
	mut row_3 := dt.row(rowIndex_1)
	if row_3 == unsafe { nil } {
		return ''
	}
	return row_3.value_as_string(columnIndex)
}

// RowValueAsStringByName reads the row record value for the specified columnName converted to a str
pub fn (mut dt DataTable) row_value_as_string_by_name(rowIndex_2 int, columnName_2 string) string {
	mut row_3 := dt.row(rowIndex_2)
	if row_3 == unsafe { nil } {
		return ''
	}
	return row_3.value_as_string_by_name(columnName_2)
}

// String get a representation of the DataTable as a str
pub fn (mut dt DataTable) string() string {
	mut image := strings.Builder{}
	image.write_string(dt.name)
	image.write_string(' [')
	for i := 0; i < dt.columns.len; i++ {
		if i > 0 {
			image.write_string(', ')
		}
		image.write_string(dt.columns[i].string())
	}
	image.write_string('] x ')
	image.write_string(format.int(dt.rows.len))
	image.write_string(' rows')
	return image.string()
}

// Select returns the rows matching the filterExpression criteria in the specified sort order. The filterExpression param
pub fn (mut dt DataTable) @select(filterExpression string, sortOrder string, limit_1 int) ([]&DataRow, error) {
	if filterExpression.len == 0 {
		filterExpression = 'True'
	}
	if limit_1 > 0 {
		filterExpression = strconv.v_sprintf('FILTER TOP %d %s WHERE %s', limit_1, dt.name,
			filterExpression)
	} else {
		filterExpression = strconv.v_sprintf('FILTER %s WHERE %s', dt.name, filterExpression)
	}
	if sortOrder.len > 0 {
		filterExpression = strconv.v_sprintf('%s ORDER BY %s', filterExpression, sortOrder)
	}
	mut expression_tree, err := generate_expression_tree(dt, filterExpression, true)
	if err != unsafe { nil } {
		return unsafe { nil }, errors.new('failed to parse filter expression, ' + err.error())
	}
	return expression_tree.@select(dt)
}
