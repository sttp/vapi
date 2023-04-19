module data

struct FunctionExpression {
mut:
	function_type ExpressionFunctionTypeEnum
	arguments     []Expression
}

// NewFunctionExpression creates a new function express
pub fn new_function_expression(functionType ExpressionFunctionTypeEnum, arguments []Expression) &FunctionExpression {
	return &FunctionExpression{
		functionType: functionType
		arguments: arguments
	}
}

// Type gets expression type of the FunctionExpress
pub fn (mut _ FunctionExpression) @type() ExpressionTypeEnum {
	return expression_type.function
}

// FunctionType gets function type of the FunctionExpress
pub fn (mut fe FunctionExpression) function_type() ExpressionFunctionTypeEnum {
	return fe.function_type
}

// Arguments gets the expression arguments of the FunctionExpress
pub fn (mut fe FunctionExpression) arguments_1() []Expression {
	return fe.arguments
}
