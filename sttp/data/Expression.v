module data

// GetValueExpression gets the expression cast to a ValueExpress
pub fn get_value_expression(expression Expression) (&ValueExpression, error) {
	if expression == unsafe { nil } {
		return unsafe { nil }, errors.new('cannot get ValueExpression, expression is nil')
	}
	if expression.@type() != expression_type.value {
		return unsafe { nil }, errors.new('expression is not a ValueExpression')
	}
	return expression, unsafe { nil }
}

// GetUnaryExpression gets the expression cast to a UnaryExpress
pub fn get_unary_expression(expression_1 Expression) (&UnaryExpression, error) {
	if expression_1 == unsafe { nil } {
		return unsafe { nil }, errors.new('cannot get UnaryExpression, expression is nil')
	}
	if expression_1.@type() != expression_type.unary {
		return unsafe { nil }, errors.new('expression is not a UnaryExpression')
	}
	return expression_1, unsafe { nil }
}

// GetColumnExpression gets the expression cast to a ColumnExpress
pub fn get_column_expression(expression_2 Expression) (&ColumnExpression, error) {
	if expression_2 == unsafe { nil } {
		return unsafe { nil }, errors.new('cannot get ColumnExpression, expression is nil')
	}
	if expression_2.@type() != expression_type.column {
		return unsafe { nil }, errors.new('expression is not a ColumnExpression')
	}
	return expression_2, unsafe { nil }
}

// GetInListExpression gets the expression cast to a InListExpress
pub fn get_in_list_expression(expression_3 Expression) (&InListExpression, error) {
	if expression_3 == unsafe { nil } {
		return unsafe { nil }, errors.new('cannot get InListExpression, expression is nil')
	}
	if expression_3.@type() != expression_type.in_list {
		return unsafe { nil }, errors.new('expression is not a InListExpression')
	}
	return expression_3, unsafe { nil }
}

// GetFunctionExpression gets the expression cast to a FunctionExpress
pub fn get_function_expression(expression_4 Expression) (&FunctionExpression, error) {
	if expression_4 == unsafe { nil } {
		return unsafe { nil }, errors.new('cannot get FunctionExpression, expression is nil')
	}
	if expression_4.@type() != expression_type.function {
		return unsafe { nil }, errors.new('expression is not a FunctionExpression')
	}
	return expression_4, unsafe { nil }
}

// GetOperatorExpression gets the expression cast to a OperatorExpress
pub fn get_operator_expression(expression_5 Expression) (&OperatorExpression, error) {
	if expression_5 == unsafe { nil } {
		return unsafe { nil }, errors.new('cannot get OperatorExpression, expression is nil')
	}
	if expression_5.@type() != expression_type.operator {
		return unsafe { nil }, errors.new('expression is not a OperatorExpression')
	}
	return expression_5, unsafe { nil }
}
