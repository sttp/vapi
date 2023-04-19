module data

struct OperatorExpression {
mut:
	operator_type ExpressionOperatorTypeEnum
	left_value    Expression
	right_value   Expression
}

// NewOperatorExpression creates a new operator express
pub fn new_operator_expression(operatorType ExpressionOperatorTypeEnum, leftValue Expression) &OperatorExpression {
	return &OperatorExpression{
		operatorType: operatorType
		leftValue: leftValue
		right_value: right_value
	}
}

// Type gets expression type of the OperatorExpress
pub fn (mut _ OperatorExpression) @type() ExpressionTypeEnum {
	return expression_type.operator
}

// OperatorType gets operator type of the OperatorExpress
pub fn (mut oe OperatorExpression) operator_type() ExpressionOperatorTypeEnum {
	return oe.operator_type
}

// LeftValue gets the left value expression of the OperatorExpress
pub fn (mut oe OperatorExpression) left_value() Expression {
	return oe.left_value
}

// RightValue gets the right value expression of the OperatorExpress
pub fn (mut oe OperatorExpression) right_value() Expression {
	return oe.right_value
}
