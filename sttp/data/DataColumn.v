module data

struct DataColumn {
mut:
	parent     &DataTable
	name       string
	data_type  DataTypeEnum
	expression string
	computed   bool
	index      int
}

fn new_data_column(parent &DataTable, name string, dataType DataTypeEnum, expression string) &DataColumn {
	return &DataColumn{
		parent: parent
		name: name
		dataType: dataType
		expression: expression
		computed: expression.len > 0
		index: -1
	}
}

// Parent gets the parent DataTable of the DataCol
pub fn (mut dc DataColumn) parent_1() &DataTable {
	return dc.parent
}

// Name gets the column name of the DataCol
pub fn (mut dc DataColumn) name_1() string {
	return dc.name
}

// Type gets the column DataType enumeration value of the DataCol
pub fn (mut dc DataColumn) @type() DataTypeEnum {
	return dc.data_type
}

// Expression gets the column expression value of the DataColumn, if
pub fn (mut dc DataColumn) expression_1() string {
	return dc.expression
}

// Computed gets a flag that determines if the DataColumn is a computed va
pub fn (mut dc DataColumn) computed() bool {
	return dc.computed
}

// Index gets the index of the DataColumn within its parent DataTable columns collect
pub fn (mut dc DataColumn) index() int {
	return dc.index
}

// String gets a representation of the DataColumn as a str
pub fn (mut dc DataColumn) string() string {
	mut data_type := dc.data_type.string()
	if dc.computed {
		data_type = 'Computed ' + data_type
	}
	return strconv.v_sprintf('%s (%s)', dc.name, data_type)
}
