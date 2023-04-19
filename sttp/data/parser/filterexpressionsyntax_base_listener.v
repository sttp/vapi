module parser

import github.com.antlr.antlr4.runtime.Go.antlr

const _ = FilterExpressionSyntaxListener(&BaseFilterExpressionSyntaxListener{})

struct BaseFilterExpressionSyntaxListener {}

// VisitTerminal is called when a terminal node is visi
pub fn (mut s BaseFilterExpressionSyntaxListener) visit_terminal(node antlr.TerminalNode) {}

// VisitErrorNode is called when an error node is visi
pub fn (mut s BaseFilterExpressionSyntaxListener) visit_error_node(node_1 antlr.ErrorNode) {}

// EnterEveryRule is called when any rule is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_every_rule(ctx antlr.ParserRuleContext) {}

// ExitEveryRule is called when any rule is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_every_rule(ctx_1 antlr.ParserRuleContext) {}

// EnterParse is called when production parse is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_parse(ctx_2 &ParseContext) {}

// ExitParse is called when production parse is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_parse(ctx_3 &ParseContext) {}

// EnterErr is called when production err is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_err(ctx_4 &ErrContext) {}

// ExitErr is called when production err is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_err(ctx_5 &ErrContext) {}

// EnterFilterExpressionStatementList is called when production filterExpressionStatementList is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_filter_expression_statement_list(ctx_6 &FilterExpressionStatementListContext) {}

// ExitFilterExpressionStatementList is called when production filterExpressionStatementList is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_filter_expression_statement_list(ctx_7 &FilterExpressionStatementListContext) {}

// EnterFilterExpressionStatement is called when production filterExpressionStatement is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_filter_expression_statement(ctx_8 &FilterExpressionStatementContext) {}

// ExitFilterExpressionStatement is called when production filterExpressionStatement is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_filter_expression_statement(ctx_9 &FilterExpressionStatementContext) {}

// EnterIdentifierStatement is called when production identifierStatement is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_identifier_statement(ctx_10 &IdentifierStatementContext) {}

// ExitIdentifierStatement is called when production identifierStatement is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_identifier_statement(ctx_11 &IdentifierStatementContext) {}

// EnterFilterStatement is called when production filterStatement is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_filter_statement(ctx_12 &FilterStatementContext) {}

// ExitFilterStatement is called when production filterStatement is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_filter_statement(ctx_13 &FilterStatementContext) {}

// EnterTopLimit is called when production topLimit is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_top_limit(ctx_14 &TopLimitContext) {}

// ExitTopLimit is called when production topLimit is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_top_limit(ctx_15 &TopLimitContext) {}

// EnterOrderingTerm is called when production orderingTerm is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_ordering_term(ctx_16 &OrderingTermContext) {}

// ExitOrderingTerm is called when production orderingTerm is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_ordering_term(ctx_17 &OrderingTermContext) {}

// EnterExpressionList is called when production expressionList is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_expression_list(ctx_18 &ExpressionListContext) {}

// ExitExpressionList is called when production expressionList is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_expression_list(ctx_19 &ExpressionListContext) {}

// EnterExpression is called when production expression is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_expression(ctx_20 &ExpressionContext) {}

// ExitExpression is called when production expression is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_expression(ctx_21 &ExpressionContext) {}

// EnterPredicateExpression is called when production predicateExpression is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_predicate_expression(ctx_22 &PredicateExpressionContext) {}

// ExitPredicateExpression is called when production predicateExpression is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_predicate_expression(ctx_23 &PredicateExpressionContext) {}

// EnterValueExpression is called when production valueExpression is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_value_expression(ctx_24 &ValueExpressionContext) {}

// ExitValueExpression is called when production valueExpression is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_value_expression(ctx_25 &ValueExpressionContext) {}

// EnterNotOperator is called when production notOperator is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_not_operator(ctx_26 &NotOperatorContext) {}

// ExitNotOperator is called when production notOperator is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_not_operator(ctx_27 &NotOperatorContext) {}

// EnterUnaryOperator is called when production unaryOperator is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_unary_operator(ctx_28 &UnaryOperatorContext) {}

// ExitUnaryOperator is called when production unaryOperator is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_unary_operator(ctx_29 &UnaryOperatorContext) {}

// EnterExactMatchModifier is called when production exactMatchModifier is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_exact_match_modifier(ctx_30 &ExactMatchModifierContext) {}

// ExitExactMatchModifier is called when production exactMatchModifier is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_exact_match_modifier(ctx_31 &ExactMatchModifierContext) {}

// EnterComparisonOperator is called when production comparisonOperator is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_comparison_operator(ctx_32 &ComparisonOperatorContext) {}

// ExitComparisonOperator is called when production comparisonOperator is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_comparison_operator(ctx_33 &ComparisonOperatorContext) {}

// EnterLogicalOperator is called when production logicalOperator is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_logical_operator(ctx_34 &LogicalOperatorContext) {}

// ExitLogicalOperator is called when production logicalOperator is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_logical_operator(ctx_35 &LogicalOperatorContext) {}

// EnterBitwiseOperator is called when production bitwiseOperator is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_bitwise_operator(ctx_36 &BitwiseOperatorContext) {}

// ExitBitwiseOperator is called when production bitwiseOperator is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_bitwise_operator(ctx_37 &BitwiseOperatorContext) {}

// EnterMathOperator is called when production mathOperator is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_math_operator(ctx_38 &MathOperatorContext) {}

// ExitMathOperator is called when production mathOperator is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_math_operator(ctx_39 &MathOperatorContext) {}

// EnterFunctionName is called when production functionName is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_function_name(ctx_40 &FunctionNameContext) {}

// ExitFunctionName is called when production functionName is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_function_name(ctx_41 &FunctionNameContext) {}

// EnterFunctionExpression is called when production functionExpression is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_function_expression(ctx_42 &FunctionExpressionContext) {}

// ExitFunctionExpression is called when production functionExpression is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_function_expression(ctx_43 &FunctionExpressionContext) {}

// EnterLiteralValue is called when production literalValue is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_literal_value(ctx_44 &LiteralValueContext) {}

// ExitLiteralValue is called when production literalValue is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_literal_value(ctx_45 &LiteralValueContext) {}

// EnterTableName is called when production tableName is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_table_name(ctx_46 &TableNameContext) {}

// ExitTableName is called when production tableName is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_table_name(ctx_47 &TableNameContext) {}

// EnterColumnName is called when production columnName is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_column_name(ctx_48 &ColumnNameContext) {}

// ExitColumnName is called when production columnName is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_column_name(ctx_49 &ColumnNameContext) {}

// EnterOrderByColumnName is called when production orderByColumnName is ente
pub fn (mut s BaseFilterExpressionSyntaxListener) enter_order_by_column_name(ctx_50 &OrderByColumnNameContext) {}

// ExitOrderByColumnName is called when production orderByColumnName is exi
pub fn (mut s BaseFilterExpressionSyntaxListener) exit_order_by_column_name(ctx_51 &OrderByColumnNameContext) {}
