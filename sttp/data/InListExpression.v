module data

struct InListExpression {
mut:
	value           Expression
	arguments       []Expression
	has_notkey_word bool
	exact_match     bool
}

// NewInListExpression creates a new in-list express
pub fn new_in_list_expression(value Expression, arguments []Expression, hasNotkeyWord bool) &InListExpression {
	return &InListExpression{
		value: value
		arguments: arguments
		hasNotkeyWord: hasNotkeyWord
		exact_match: exact_match
	}
}

// Type gets expression type of the InListExpress
pub fn (mut _ InListExpression) @type() ExpressionTypeEnum {
	return expression_type.in_list
}

// Value gets the expression value of the InListExpress
pub fn (mut ile InListExpression) value_1() Expression {
	return ile.value
}

// Arguments gets the expression arguments of the InListExpress
pub fn (mut ile InListExpression) arguments_1() []Expression {
	return ile.arguments
}

// HasNotKeyword gets a flag that determines if the InListExpression has the \"NOT\" keyw
pub fn (mut ile InListExpression) has_not_keyword() bool {
	return ile.has_notkey_word
}

// ExtactMatch gets a flags that determines if the InListExpression has the \"BINARY\" or \"===\" keyw
pub fn (mut ile InListExpression) extact_match() bool {
	return ile.exact_match
}
