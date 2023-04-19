module data

struct ColumnExpression {
mut:
	data_column &DataColumn
}

// NewColumnExpression creates a new column express
pub fn new_column_expression(dataColumn &DataColumn) &ColumnExpression {
	return &ColumnExpression{
		dataColumn: dataColumn
	}
}

// Type gets expression type of the ColumnExpress
pub fn (mut _ ColumnExpression) @type() ExpressionTypeEnum {
	return expression_type.column
}

// DataColumn gets the data column of the ColumnExpress
pub fn (mut ce ColumnExpression) data_column() &data_column {
	return ce.data_column
}
