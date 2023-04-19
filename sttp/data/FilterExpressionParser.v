module data
import math
import strconv
import strings
import time
import github.com.antlr.antlr4.runtime.Go.antlr
import github.com.araddon.dateparse
import github.com.shopspring.decimal
import parser
import github.com.sttp.goapi.sttp.guid
import github.com.sttp.goapi.sttp.hashset
struct FilterExpressionParser {&parser.BaseFilterExpressionSyntaxListener

mut:
input_stream &antlr.InputStream 
lexer &parser.FilterExpressionSyntaxLexer 
tokens &antlr.CommonTokenStream 
parser &parser.FilterExpressionSyntaxParser 
error_listener &CallbackErrorListener 
filtered_rows []&DataRow 
filtered_row_set hashset.HashSet 
filtered_signal_ids []guid.Guid 
filtered_signal_idset hashset.HashSet 
filter_expression_statement_count int 
active_expression_tree &ExpressionTree 
expression_trees []&ExpressionTree 
expressions map[antlr.ParserRuleContext]Expression 
data_set &DataSet 
primary_table_name string 
table_idfields map[string]&TableIDFields 
track_filtered_rows bool 
track_filtered_signal_ids bool 
}
// NewFilterExpressionParser creates a new FilterExpressionPar
pub fn new_filter_expression_parser(filterExpression string, suppressConsoleErrorOutput bool) (&FilterExpressionParser, ) {mut fep:=new(FilterExpressionParser ,)  
fep.input_stream=antlr.new_input_stream(filterExpression ,)  
fep.lexer=parser.new_filter_expression_syntax_lexer(fep.input_stream ,)  
fep.tokens=antlr.new_common_token_stream(fep.lexer ,0 ,)  
fep.parser=parser.new_filter_expression_syntax_parser(fep.tokens ,)  
fep.error_listener=new_callback_error_listener()  
fep.expression_trees=[]*ExpressionTree{len: 0 }  
fep.expressions=map[antlr.ParserRuleContext]Expression{}  
fep.table_idfields=map[string]*TableIDFields{}  
fep.track_filtered_rows=true  
if suppressConsoleErrorOutput {
fep.parser.remove_error_listeners()
}
fep.parser.add_error_listener(fep.error_listener ,)
return fep 
}

// NewFilterExpressionParserForDataSet creates a new filter expression parser associated with the provided dat
pub fn new_filter_expression_parser_for_data_set(dataSet &DataSet, filterExpression_1 string, primaryTable string, tableIDFields &TableIDFields, suppressConsoleErrorOutput_1 bool) (&FilterExpressionParser, error, ) {if dataSet  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("dataSet parameter is nil" ,) 
}
if filterExpression_1 .len  ==  0  {
return unsafe { nil } ,errors.new("filter expression is empty" ,) 
}
mut parser:=new_filter_expression_parser(filterExpression_1 ,suppressConsoleErrorOutput_1 ,)  
parser.data_set=dataSet  
if primaryTable .len  >  0  {
parser.primary_table_name=primaryTable  
if tableIDFields  ==  unsafe { nil }  {
parser.table_idfields[primaryTable ]=default_table_idfields  
}else {
parser.table_idfields[primaryTable ]=tableIDFields  
}
}
return parser ,unsafe { nil } 
}

// SetParsingExceptionCallback registers a callback for receiving parsing exception messa
pub fn (mut fep FilterExpressionParser) set_parsing_exception_callback(callback fn ( string) ) {fep.error_listener.parsing_exception_callback=callback  
}

// ExpressionTrees gets the expression trees, parsing the filter expression if nee
pub fn (mut fep FilterExpressionParser) expression_trees() ([]&ExpressionTree, error, ) {if fep.expression_trees .len  ==  0  {
mut err:=fep.visit_parse_tree_nodes() 
if err  !=  unsafe { nil }  {
return unsafe { nil } ,err 
}
}
return fep.expression_trees ,unsafe { nil } 
}

// FilteredRows gets the rows matching the parsed filter express
pub fn (mut fep FilterExpressionParser) filtered_rows() ([]&DataRow, ) {return fep.filtered_rows 
}

// FilteredRowSet gets the unique row set matching the parsed filter express
pub fn (mut fep FilterExpressionParser) filtered_row_set() (hashset.HashSet, ) {fep.initialize_set_operations()
return fep.filtered_row_set 
}

// FilteredSignalIDs gets the Guid-based signalIDs matching the parsed filter express
pub fn (mut fep FilterExpressionParser) filtered_signal_ids() ([]guid.Guid, ) {return fep.filtered_signal_ids 
}

// FilteredSignalIDSet gets the unique Guid-based signalID set matching the parsed filter express
pub fn (mut fep FilterExpressionParser) filtered_signal_idset() (hashset.HashSet, ) {fep.initialize_set_operations()
return fep.filtered_signal_idset 
}

// FilterExpressionStatementCount gets the number filter expression statements encountered while pars
pub fn (mut fep FilterExpressionParser) filter_expression_statement_count() (int, ) {return fep.filter_expression_statement_count 
}

// Table gets the DataTable for the specified tableName from the FilterExpressionParser Data
pub fn (mut fep FilterExpressionParser) table(tableName string) (&DataTable, error, ) {if fep.data_set  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("no DataSet has been defined" ,) 
}
mut table_1:=fep.data_set.table(tableName ,)  
if table_1  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("failed to find table \""  +  tableName   +  "\" in DataSet"  ,) 
}
return table_1 ,unsafe { nil } 
}

// Evaluate parses each statement in the filter expression and tracks the results. Filter expressions can contain multiple stateme
pub fn (mut fep FilterExpressionParser) evaluate(applyLimit bool, applySort bool) (error, ) {if fep.data_set  ==  unsafe { nil }  {
return errors.new("no DataSet has been defined" ,) 
}
if ! fep.track_filtered_rows   &&  ! fep.track_filtered_signal_ids   {
return errors.new("no use in evaluating filter expression, neither filtered rows nor signal IDs have been set for tracking" ,) 
}
fep.filter_expression_statement_count=0  
fep.filtered_rows=[]*DataRow{len: 0 }  
fep.filtered_row_set=unsafe { nil }  
fep.filtered_signal_ids=[]guid.Guid{len: 0 }  
fep.filtered_signal_idset=unsafe { nil }  
fep.expression_trees=[]*ExpressionTree{len: 0 }  
fep.expressions=map[antlr.ParserRuleContext]Expression{}  
mut err:=fep.visit_parse_tree_nodes() 
if err  !=  unsafe { nil }  {
return err 
}
for _, expression_tree in  fep.expression_trees  {
mut table_name:=expression_tree.table_name  
if table_name .len  ==  0  {
if fep.primary_table_name .len  ==  0  {
return errors.new("no table name defined for expression tree nor is any PrimaryTableName defined" ,) 
}
table_name=fep.primary_table_name  
}
mut table_1,err_1:=fep.table(table_name ,)  
if err_1  !=  unsafe { nil }  {
return err_1 
}
mut matched_rows,err_2:=expression_tree.select_where(table_1 ,fn (resultExpression &ValueExpression) (bool, error, ) {mut result_type:=resultExpression.value_type()  
if result_type  ==  expression_value_type.boolean  {
return resultExpression.boolean_value() ,unsafe { nil } 
}
return false ,unsafe { nil } 
}
 ,applyLimit ,applySort ,)  
if err_2  !=  unsafe { nil }  {
return err_2 
}
mut signal_idcolumn_index:=- 1   
if fep.track_filtered_signal_ids {
mut primary_table_idfields:=fep.table_idfields[table_1.name() ]  
if primary_table_idfields  ==  unsafe { nil }  {
return errors.new("failed to find ID fields record for table \""  +  table_1.name()   +  "\""  ,) 
}
mut signal_idcolumn:=table_1.column_by_name(primary_table_idfields.signal_idfield_name ,)  
if signal_idcolumn  ==  unsafe { nil }  {
return errors.new("failed to find signal ID field \""  +  primary_table_idfields.signal_idfield_name   +  "\" for table \""   +  table_1.name()   +  "\""  ,) 
}
signal_idcolumn_index=signal_idcolumn.index()  
}
for _, matched_row in  matched_rows  {
fep.add_matched_row(matched_row ,signal_idcolumn_index ,)
}
}
return unsafe { nil } 
}

fn (mut fep FilterExpressionParser) visit_parse_tree_nodes() (error, ) {mut err:=error{}
defer {mut r:=recover() 
if r  !=  unsafe { nil }  {
mut rt:=r  match r .type_name() {'string' {
err=errors.new(rt ,)  
}
'error' {
err=rt  
}
else{
err=errors.new("unknown panic" ,)  
}
}
}
}
mut walker:=antlr.new_parse_tree_walker()  
mut parse_tree:=fep.parser.parse()  
walker.walk(fep ,parse_tree ,)
return err 
}

fn (mut fep FilterExpressionParser) initialize_set_operations() {if fep.track_filtered_rows  &&  fep.filtered_row_set  ==  unsafe { nil }   {
mut count:=fep.filtered_rows .len  
fep.filtered_row_set=hashset.hash_set[*DataRow ] {len: count }  
for i:=0  ;i  <  count  ;i++ {
fep.filtered_row_set.add(fep.filtered_rows[i ] ,)
}
}
if fep.track_filtered_signal_ids  &&  fep.filtered_signal_idset  ==  unsafe { nil }   {
mut count:=fep.filtered_signal_ids .len  
fep.filtered_signal_idset=hashset.hash_set[guid.guid ] {len: count }  
for i:=0  ;i  <  count  ;i++ {
fep.filtered_signal_idset.add(fep.filtered_signal_ids[i ] ,)
}
}
}

fn (mut fep FilterExpressionParser) add_matched_row(row &DataRow, signalIDColumnIndex int) {if fep.filter_expression_statement_count  >  1  {
if fep.track_filtered_rows  &&  fep.filtered_row_set.add(row ,)  {
fep.filtered_rows <<row   
}
if fep.track_filtered_signal_ids {
mut signal_idfield,null,err_1:=row.guid_value(signalIDColumnIndex ,)  
if ! null   &&  err_1  ==  unsafe { nil }    &&  ! signal_idfield.is_zero()    &&  fep.filtered_signal_idset.add(signal_idfield ,)  {
fep.filtered_signal_ids <<signal_idfield   
}
}
}else {
if fep.track_filtered_rows {
fep.filtered_rows <<row   
}
if fep.track_filtered_signal_ids {
mut signal_idfield,null,err_1:=row.guid_value(signalIDColumnIndex ,)  
if ! null   &&  err_1  ==  unsafe { nil }    &&  ! signal_idfield.is_zero()   {
fep.filtered_signal_ids <<signal_idfield   
}
}
}
}

fn (mut fep FilterExpressionParser) map_matched_field_row(primaryTable_1 &DataTable, columnName string, matchValue string, signalIDColumnIndex_1 int) {mut column:=primaryTable_1.column_by_name(columnName ,)  
if column  ==  unsafe { nil }  {
return 
}
matchValue=matchValue .to_upper()  
mut column_index:=column.index()  
for i:=0  ;i  <  primaryTable_1.row_count()  ;i++ {
mut row_1:=primaryTable_1.row(i ,)  
if row_1  ==  unsafe { nil }  {
continue 
}
mut value,null,err_1:=row_1.string_value(column_index ,)  
if ! null   &&  err_1  ==  unsafe { nil }    &&  matchValue  ==  value .to_upper()   {
fep.add_matched_row(row_1 ,signalIDColumnIndex_1 ,)
return 
}
}
}

fn (mut fep FilterExpressionParser) try_get_expr(context antlr.ParserRuleContext, expression &Expression) (bool, ) {mut ok:=false 
*expression,ok=fep.expressions[context ]  
return ok 
}

fn (mut fep FilterExpressionParser) add_expr(context_1 antlr.ParserRuleContext, expression_1 Expression) {fep.expressions[context_1 ]=expression_1  
fep.active_expression_tree.root=expression_1  
}

// EnterFilterExpressionStatement is called when production filterExpressionStatement is ente
pub fn (mut fep FilterExpressionParser) enter_filter_expression_statement(context_2 &parser.FilterExpressionStatementContext) {fep.expressions=map[antlr.ParserRuleContext]Expression{}  
fep.active_expression_tree=unsafe { nil }  
fep.filterExpressionStatementCount++
if fep.filter_expression_statement_count  ==  2  {
fep.initialize_set_operations()
}
}

// EnterFilterStatement is called when production filterStatement is ente
pub fn (mut fep FilterExpressionParser) enter_filter_statement(context_3 &parser.FilterStatementContext) {mut table_name:=context_3.table_name.get_text()  
mut table_1,err_1:=fep.table(table_name ,)  
if err_1  !=  unsafe { nil }  {
panic("cannot parse filter expression statement, "  +  err_1.error()  ,)
}
fep.active_expression_tree=new_expression_tree()  
fep.active_expression_tree.table_name=table_name  
fep.expression_trees <<fep.active_expression_tree   
if context_3.k_top()  !=  unsafe { nil }  {
mut top_limit,err_2:=strconv.atoi(context_3.top_limit.get_text() ,)  
if err_2  ==  unsafe { nil }  {
fep.active_expression_tree.top_limit=top_limit  
}else {
fep.active_expression_tree.top_limit=- 1   
}
}
if context_3.k_order()  !=  unsafe { nil }   &&  context_3.k_by()  !=  unsafe { nil }   {
mut ordering_terms:=context_3.all_ordering_term()  
for i:=0  ;i  <  ordering_terms .len  ;i++ {
mut ordering_term_context:=ordering_terms[i ]  
mut order_by_column_name:=ordering_term_context.order_by_column_name.get_text()  
mut order_by_column:=table_1.column_by_name(order_by_column_name ,)  
if order_by_column  ==  unsafe { nil }  {
panic("cannot parse filter expression statement, failed to find order by field \""  +  order_by_column_name   +  "\" for table \""   +  table_name   +  "\""  ,)
}
fep.active_expression_tree.order_by_terms <<& OrderByTerm{
column:order_by_column  ,
ascending:ordering_term_context.k_desc()  ==  unsafe { nil }   ,
exact_match:ordering_term_context.exact_match_modifier()  ==  unsafe { nil }   }    
}
}
}

fn parse_guid_literal(guidLiteral string) (guid.Guid, ) {if guidLiteral[0 ]  ==  `\'`  {
guidLiteral=guidLiteral[1 ..guidLiteral .len  -  1  ]  
}
mut g,err_1:=guid.parse(guidLiteral ,)  
if err_1  !=  unsafe { nil }  {
panic("failed to parse Guid literal "  +  guidLiteral   +  ": "   +  err_1.error()  ,)
}
return g 
}

fn parse_point_tag_literal(pointTagLiteral string) (string, ) {if pointTagLiteral[0 ]  ==  `"`  {
return pointTagLiteral[1 ..pointTagLiteral .len  -  1  ] 
}
return pointTagLiteral 
}

// ExitIdentifierStatement is called when production identifierStatement is exi
pub fn (mut fep FilterExpressionParser) exit_identifier_statement(context_4 &parser.IdentifierStatementContext) {mut signal_id:=guid.empty  
if context_4.guid_literal()  !=  unsafe { nil }  {
signal_id=parse_guid_literal(context_4.guid_literal.get_text() ,)  
if ! fep.track_filtered_rows   &&  ! fep.track_filtered_signal_ids   {
fep.enter_expression(unsafe { nil } ,)
fep.active_expression_tree.root=new_value_expression(expression_value_type.guid ,signal_id ,)  
return 
}
if fep.track_filtered_signal_ids  &&  ! signal_id.is_zero()   {
if fep.filter_expression_statement_count  >  1  {
if fep.filtered_signal_idset.add(signal_id ,) {
fep.filtered_signal_ids <<signal_id   
}
}else {
fep.filtered_signal_ids <<signal_id   
}
}
if ! fep.track_filtered_rows  {
return 
}
}
if fep.data_set  ==  unsafe { nil }  {
return 
}
mut primary_table:=fep.data_set.table(fep.primary_table_name ,)  
if primary_table  ==  unsafe { nil }  {
return 
}
mut primary_table_idfields,ok:=fep.table_idfields[fep.primary_table_name ]  
if ! ok   ||  primary_table_idfields  ==  unsafe { nil }   {
return 
}
mut signal_idcolumn:=primary_table.column_by_name(primary_table_idfields.signal_idfield_name ,)  
if signal_idcolumn  ==  unsafe { nil }  {
return 
}
mut signal_idcolumn_index:=signal_idcolumn.index()  
if fep.track_filtered_rows  &&  ! signal_id.is_zero()   {
for i:=0  ;i  <  primary_table.row_count()  ;i++ {
mut row_1:=primary_table.row(i ,)  
if row_1  ==  unsafe { nil }  {
continue 
}
mut value,null,err_1:=row_1.guid_value(signal_idcolumn_index ,)  
if ! null   &&  err_1  ==  unsafe { nil }    &&  value  ==  signal_id   {
if fep.filter_expression_statement_count  >  1  {
if fep.filtered_row_set.add(row_1 ,) {
fep.filtered_rows <<row_1   
}
}else {
fep.filtered_rows <<row_1   
}
return 
}
}
return 
}
if context_4.measurement_key_literal()  !=  unsafe { nil }  {
fep.map_matched_field_row(primary_table ,primary_table_idfields.measurement_key_field_name ,context_4.measurement_key_literal.get_text() ,signal_idcolumn_index ,)
return 
}
if context_4.point_tag_literal()  !=  unsafe { nil }  {
fep.map_matched_field_row(primary_table ,primary_table_idfields.point_tag_field_name ,parse_point_tag_literal(context_4.point_tag_literal.get_text() ,) ,signal_idcolumn_index ,)
}
}

// EnterExpression is called when production expression is ente
pub fn (mut fep FilterExpressionParser) enter_expression(0 &parser.ExpressionContext) {if fep.active_expression_tree  ==  unsafe { nil }  {
fep.active_expression_tree=new_expression_tree()  
fep.expression_trees <<fep.active_expression_tree   
}
}

// ExitExpression is called when production expression is exi
pub fn (mut fep FilterExpressionParser) exit_expression(context_5 &parser.ExpressionContext) {mut value:=Expression{} 
mut predicate_expression:=context_5.predicate_expression()  
if predicate_expression  !=  unsafe { nil }  {
if fep.try_get_expr(predicate_expression ,& value  ,) {
fep.add_expr(context_5 ,value ,)
return 
}
panic("failed to find predicate expression \""  +  predicate_expression.get_text()   +  "\""  ,)
}
mut not_operator:=context_5.not_operator()  
if not_operator  !=  unsafe { nil }  {
mut expressions:=context_5.all_expression()  
if expressions .len  !=  1  {
panic("not operator expression is malformed: \""  +  context_5.get_text()   +  "\""  ,)
}
if ! fep.try_get_expr(expressions[0 ] ,& value  ,)  {
panic("failed to find not operator expression \""  +  context_5.get_text()   +  "\""  ,)
}
fep.add_expr(context_5 ,new_unary_expression(expression_unary_type.not ,value ,) ,)
return 
}
mut logical_operator:=context_5.logical_operator()  
if logical_operator  !=  unsafe { nil }  {
mut logical_operator_context:=logical_operator  
mut left_value,right_value:=Expression{},Expression{} 
mut operator_type:=ExpressionOperatorTypeEnum{} 
mut expressions:=context_5.all_expression()  
if expressions .len  !=  2  {
panic("operator expression, in logical operator expression context, is malformed: \""  +  context_5.get_text()   +  "\""  ,)
}
if ! fep.try_get_expr(expressions[0 ] ,& left_value  ,)  {
panic("failed to find left operator expression \""  +  expressions[0 ].get_text()   +  "\""  ,)
}
if ! fep.try_get_expr(expressions[1 ] ,& right_value  ,)  {
panic("failed to find right operator expression \""  +  expressions[1 ].get_text()   +  "\""  ,)
}
mut operator_symbol:=logical_operator_context.get_text()  
if logical_operator_context.k_and()  !=  unsafe { nil }   ||  operator_symbol  ==  "&&"   {
operator_type=expression_operator_type.and  
}else if logical_operator_context.k_or()  !=  unsafe { nil }   ||  operator_symbol  ==  "||"   {
operator_type=expression_operator_type.@or  
}else {
panic("unexpected logical operator \""  +  operator_symbol   +  "\""  ,)
}
fep.add_expr(context_5 ,new_operator_expression(operator_type ,left_value ,right_value ,) ,)
return 
}
panic("unexpected expression \""  +  context_5.get_text()   +  "\""  ,)
}

// ExitPredicateExpression is called when production predicateExpression is exi
pub fn (mut fep FilterExpressionParser) exit_predicate_expression(context_6 &parser.PredicateExpressionContext) {mut value:=Expression{} 
mut value_expression:=context_6.value_expression()  
if value_expression  !=  unsafe { nil }  {
if fep.try_get_expr(value_expression ,& value  ,) {
fep.add_expr(context_6 ,value ,)
return 
}
panic("failed to find value expression \""  +  value_expression.get_text()   +  "\""  ,)
}
mut not_operator:=context_6.not_operator()  
mut exact_match_modifier:=context_6.exact_match_modifier()  
if context_6.k_in()  !=  unsafe { nil }  {
mut predicates:=context_6.all_predicate_expression()  
if predicates .len  !=  1  {
panic("\"IN\" expression is malformed: \""  +  context_6.get_text()   +  "\""  ,)
}
if ! fep.try_get_expr(predicates[0 ] ,& value  ,)  {
panic("failed to find \"IN\" predicate expression \""  +  predicates[0 ].get_text()   +  "\""  ,)
}
mut expression_list_context:=context_6.ExpressionList  
mut expressions:=expression_list_context.all_expression()  
mut argument_count:=expressions .len  
if argument_count  <  1  {
panic("not enough expressions found for \"IN\" operation" ,)
}
mut arguments:=[]Expression{len: 0 }  
for i:=0  ;i  <  argument_count  ;i++ {
mut argument:=Expression{} 
if fep.try_get_expr(expressions[i ] ,& argument  ,) {
arguments <<argument   
}else {
panic("failed to find argument expression "  +  strconv.itoa(i ,)   +  " \""   +  expressions[i ].get_text()   +  "\" for \"IN\" operation"  ,)
}
}
fep.add_expr(context_6 ,new_in_list_expression(value ,arguments ,not_operator  !=  unsafe { nil }  ,exact_match_modifier  !=  unsafe { nil }  ,) ,)
return 
}
if context_6.k_is()  !=  unsafe { nil }   &&  context_6.k_null()  !=  unsafe { nil }   {
mut operator_type:=ExpressionOperatorTypeEnum{} 
if not_operator  ==  unsafe { nil }  {
operator_type=expression_operator_type.is_null  
}else {
operator_type=expression_operator_type.is_not_null  
}
mut predicates:=context_6.all_predicate_expression()  
if predicates .len  !=  1  {
panic("\"IS NULL\" expression is malformed: \""  +  context_6.get_text()   +  "\""  ,)
}
if fep.try_get_expr(predicates[0 ] ,& value  ,) {
fep.add_expr(context_6 ,new_operator_expression(operator_type ,value ,unsafe { nil } ,) ,)
return 
}
panic("failed to find \"IS NULL\" predicate expression \""  +  predicates[0 ].get_text()   +  "\""  ,)
}
mut predicates:=context_6.all_predicate_expression()  
if predicates .len  !=  2  {
panic("operator expression, in predicate expression context, is malformed: \""  +  context_6.get_text()   +  "\""  ,)
}
mut left_value,right_value:=Expression{},Expression{} 
mut operator_type:=ExpressionOperatorTypeEnum{} 
if ! fep.try_get_expr(predicates[0 ] ,& left_value  ,)  {
panic("failed to find left operator predicate expression \""  +  predicates[0 ].get_text()   +  "\""  ,)
}
if ! fep.try_get_expr(predicates[1 ] ,& right_value  ,)  {
panic("failed to find right operator predicate expression \""  +  predicates[1 ].get_text()   +  "\""  ,)
}
mut comparison_operator:=context_6.comparison_operator()  
if comparison_operator  !=  unsafe { nil }  {
mut operator_symbol:=comparison_operator.get_text()  
 match operator_symbol {"<" {
operator_type=expression_operator_type.less_than  
}
"<=" {
operator_type=expression_operator_type.less_than_or_equal  
}
">" {
operator_type=expression_operator_type.greater_than  
}
">=" {
operator_type=expression_operator_type.greater_than_or_equal  
}
"=" ,"==" {
operator_type=expression_operator_type.equal  
}
"===" {
operator_type=expression_operator_type.equal_exact_match  
}
"<>" ,"!=" {
operator_type=expression_operator_type.not_equal  
}
"!==" {
operator_type=expression_operator_type.not_equal_exact_match  
}
else{
panic("unexpected comparison operator \""  +  operator_symbol   +  "\""  ,)
}
}
fep.add_expr(context_6 ,new_operator_expression(operator_type ,left_value ,right_value ,) ,)
return 
}
if context_6.k_like()  !=  unsafe { nil }  {
mut operator_type_1:=ExpressionOperatorTypeEnum{} 
if exact_match_modifier  ==  unsafe { nil }  {
if not_operator  ==  unsafe { nil }  {
operator_type_1=expression_operator_type.like  
}else {
operator_type_1=expression_operator_type.not_like  
}
}else {
if not_operator  ==  unsafe { nil }  {
operator_type_1=expression_operator_type.like_exact_match  
}else {
operator_type_1=expression_operator_type.not_like_exact_match  
}
}
fep.add_expr(context_6 ,new_operator_expression(operator_type_1 ,left_value ,right_value ,) ,)
return 
}
panic("unexpected predicate expression \""  +  context_6.get_text()   +  "\""  ,)
}

// ExitValueExpression is called when production valueExpression is exi
pub fn (mut fep FilterExpressionParser) exit_value_expression(context_7 &parser.ValueExpressionContext) {mut value:=Expression{} 
mut literal_value:=context_7.literal_value()  
if literal_value  !=  unsafe { nil }  {
if fep.try_get_expr(literal_value ,& value  ,) {
fep.add_expr(context_7 ,value ,)
return 
}
panic("failed to find literal value \""  +  literal_value.get_text()   +  "\""  ,)
}
mut column_name:=context_7.column_name()  
if column_name  !=  unsafe { nil }  {
if fep.try_get_expr(column_name ,& value  ,) {
fep.add_expr(context_7 ,value ,)
return 
}
panic("failed to find column name \""  +  column_name.get_text()   +  "\""  ,)
}
mut function_expression:=context_7.function_expression()  
if function_expression  !=  unsafe { nil }  {
if fep.try_get_expr(function_expression ,& value  ,) {
fep.add_expr(context_7 ,value ,)
return 
}
panic("failed to find function expression \""  +  function_expression.get_text()   +  "\""  ,)
}
mut unary_operator:=context_7.unary_operator()  
if unary_operator  !=  unsafe { nil }  {
mut value_expressions:=context_7.all_value_expression()  
if value_expressions .len  !=  1  {
panic("unary operator value expression is malformed: \""  +  context_7.get_text()   +  "\""  ,)
}
if fep.try_get_expr(value_expressions[0 ] ,& value  ,) {
mut unary_type:=ExpressionUnaryTypeEnum{} 
mut unary_operator_context:=unary_operator  
if unary_operator_context.k_not()  ==  unsafe { nil }  {
mut operator_symbol:=unary_operator_context.get_text()  
 match operator_symbol {"+" {
unary_type=expression_unary_type.plus  
}
"-" {
unary_type=expression_unary_type.minus  
}
"~" ,"!" {
unary_type=expression_unary_type.not  
}
else{
panic("unexpected unary operator type \""  +  operator_symbol   +  "\""  ,)
}
}
}else {
unary_type=expression_unary_type.not  
}
fep.add_expr(context_7 ,new_unary_expression(unary_type ,value ,) ,)
return 
}
panic("failed to find unary operator value expression \""  +  context_7.get_text()   +  "\""  ,)
}
mut expression_2:=context_7.expression()  
if expression_2  !=  unsafe { nil }  {
if fep.try_get_expr(expression_2 ,& value  ,) {
fep.add_expr(context_7 ,value ,)
return 
}
panic("failed to find sub-expression \""  +  expression_2.get_text()   +  "\""  ,)
}
mut value_expressions:=context_7.all_value_expression()  
if value_expressions .len  !=  2  {
panic("operator expression, in value expression context, is malformed: \""  +  context_7.get_text()   +  "\""  ,)
}
mut left_value,right_value:=Expression{},Expression{} 
mut operator_type:=ExpressionOperatorTypeEnum{} 
if ! fep.try_get_expr(value_expressions[0 ] ,& left_value  ,)  {
panic("failed to find left operator value expression \""  +  value_expressions[0 ].get_text()   +  "\""  ,)
}
if ! fep.try_get_expr(value_expressions[1 ] ,& right_value  ,)  {
panic("failed to find right operator value expression \""  +  value_expressions[1 ].get_text()   +  "\""  ,)
}
mut math_operator:=context_7.math_operator()  
if math_operator  !=  unsafe { nil }  {
mut operator_symbol:=math_operator.get_text()  
 match operator_symbol {"*" {
operator_type=expression_operator_type.multiply  
}
"/" {
operator_type=expression_operator_type.divide  
}
"%" {
operator_type=expression_operator_type.modulus  
}
"+" {
operator_type=expression_operator_type.add  
}
"-" {
operator_type=expression_operator_type.subtract  
}
else{
panic("unexpected math operator \""  +  operator_symbol   +  "\""  ,)
}
}
fep.add_expr(context_7 ,new_operator_expression(operator_type ,left_value ,right_value ,) ,)
return 
}
mut bitwise_operator:=context_7.bitwise_operator()  
if bitwise_operator  !=  unsafe { nil }  {
mut bitwise_operator_context:=bitwise_operator  
if bitwise_operator_context.k_xor()  ==  unsafe { nil }  {
mut operator_symbol:=bitwise_operator_context.get_text()  
 match operator_symbol {"<<" {
operator_type=expression_operator_type.bit_shift_left  
}
">>" {
operator_type=expression_operator_type.bit_shift_right  
}
"&" {
operator_type=expression_operator_type.bitwise_and  
}
"|" {
operator_type=expression_operator_type.bitwise_or  
}
"^" {
operator_type=expression_operator_type.bitwise_xor  
}
else{
panic("unexpected bitwise operator \""  +  operator_symbol   +  "\""  ,)
}
}
}else {
operator_type=expression_operator_type.bitwise_xor  
}
fep.add_expr(context_7 ,new_operator_expression(operator_type ,left_value ,right_value ,) ,)
return 
}
panic("unexpected value expression \""  +  context_7.get_text()   +  "\""  ,)
}

fn parse_numeric_literal(literal_1 string) (&ValueExpression, ) {mut d,err_3:=decimal.new_from_string(literal_1 ,) 
if err_3  ==  unsafe { nil }  {
return new_value_expression(expression_value_type.decimal ,d ,) 
}
mut f64,err_4:=strconv.parse_float(literal_1 ,64 ,) 
if err_4  ==  unsafe { nil }  {
return new_value_expression(expression_value_type.double ,f64 ,) 
}
return new_value_expression(expression_value_type.string ,literal_1 ,) 
}

fn parse_string_literal(stringLiteral string) (string, ) {if stringLiteral[0 ]  ==  `\'`  {
return stringLiteral[1 ..stringLiteral .len  -  1  ] 
}
return stringLiteral 
}

fn parse_date_time_literal(dateTimeLiteral string) (time.Time, ) {if dateTimeLiteral[0 ]  ==  `#`  {
dateTimeLiteral=dateTimeLiteral[1 ..dateTimeLiteral .len  -  1  ]  
}
mut dt,err_1:=dateparse.parse_any(dateTimeLiteral ,)  
if err_1  !=  unsafe { nil }  {
panic("failed to parse DateTime literal #"  +  dateTimeLiteral   +  "#: "   +  err_1.error()  ,)
}
return dt.utc() 
}

// ExitLiteralValue is called when production literalValue is exi
pub fn (mut fep FilterExpressionParser) exit_literal_value(context_8 &parser.LiteralValueContext) {mut result:=&ValueExpression{} 
mut integer_literal:=context_8.integer_literal() 
mut numeric_literal:=context_8.numeric_literal() 
mut string_literal:=context_8.string_literal() 
mut data_time_literal:=context_8.datetime_literal() 
mut guid_literal:=context_8.guid_literal() 
mut boolean_literal:=context_8.boolean_literal() 
if integer_literal  !=  unsafe { nil }  {
mut literal:=integer_literal.get_text()  
mut i64,err_1:=strconv.parse_int(literal ,0 ,64 ,) 
mut ui64,err_2:=strconv.parse_uint(literal ,0 ,64 ,) 
mut d,err_3:=decimal.new_from_string(literal ,) 
if err_1  ==  unsafe { nil }  {
if i64  >  math.max_int32  {
result=new_value_expression(expression_value_type.int64 ,i64 ,)  
}else {
result=new_value_expression(expression_value_type.int32 ,i32(i64 ,) ,)  
}
}else if err_2  ==  unsafe { nil }  {
if ui64  >  math.max_int64  {
result=parse_numeric_literal(literal ,)  
}else if ui64  >  math.max_int32  {
result=new_value_expression(expression_value_type.int64 ,i64(ui64 ,) ,)  
}else {
result=new_value_expression(expression_value_type.int32 ,i32(ui64 ,) ,)  
}
}else if err_3  ==  unsafe { nil }  {
result=new_value_expression(expression_value_type.decimal ,d ,)  
}else {
result=new_value_expression(expression_value_type.string ,literal ,)  
}
}else if numeric_literal  !=  unsafe { nil }  {
mut literal:=numeric_literal.get_text()  
if literal .contains_any("Ee" ,) {
mut f64,err_1:=strconv.parse_float(literal ,64 ,) 
if err_1  ==  unsafe { nil }  {
result=new_value_expression(expression_value_type.double ,f64 ,)  
}else {
result=parse_numeric_literal(literal ,)  
}
}else {
result=parse_numeric_literal(literal ,)  
}
}else if string_literal  !=  unsafe { nil }  {
result=new_value_expression(expression_value_type.string ,parse_string_literal(string_literal.get_text() ,) ,)  
}else if data_time_literal  !=  unsafe { nil }  {
result=new_value_expression(expression_value_type.date_time ,parse_date_time_literal(data_time_literal.get_text() ,) ,)  
}else if guid_literal  !=  unsafe { nil }  {
result=new_value_expression(expression_value_type.guid ,parse_guid_literal(guid_literal.get_text() ,) ,)  
}else if boolean_literal  !=  unsafe { nil }  {
if boolean_literal.get_text() .to_upper()  ==  "TRUE"  {
result=true  
}else {
result=false  
}
}else if context_8.k_null()  !=  unsafe { nil }  {
result=null_value(expression_value_type.undefined ,)  
}
if result  !=  unsafe { nil }  {
fep.add_expr(context_8 ,result ,)
}
}

// ExitColumnName is called when production columnName is exi
pub fn (mut fep FilterExpressionParser) exit_column_name(context_9 &parser.ColumnNameContext) {mut table_name:=fep.active_expression_tree.table_name  
if table_name .len  ==  0  {
if fep.primary_table_name .len  ==  0  {
panic("cannot parse column name in filter expression, no table name defined for expression tree nor is any PrimaryTableName defined." ,)
}
table_name=fep.primary_table_name  
}
mut table_1,err_1:=fep.table(table_name ,)  
if err_1  !=  unsafe { nil }  {
panic("cannot parse column name in filter expression, "  +  err_1.error()  ,)
}
mut column_name:=context_9.identifier.get_text()  
mut data_column:=table_1.column_by_name(column_name ,)  
if data_column  ==  unsafe { nil }  {
panic("cannot parse column name in filter expression, failed to find column \""  +  column_name   +  "\" in table \""   +  table_name   +  "\""  ,)
}
fep.add_expr(context_9 ,new_column_expression(data_column ,) ,)
}

// ExitFunctionExpression is called when production functionExpression is exi
pub fn (mut fep FilterExpressionParser) exit_function_expression(context_10 &parser.FunctionExpressionContext) {mut function_name_context:=context_10.FunctionName  
mut function_type:=ExpressionFunctionTypeEnum{} 
 match true {(function_name_context.k_abs()  !=  unsafe { nil }  ){
function_type=expression_function_type.abs  
}
(function_name_context.k_ceiling()  !=  unsafe { nil }  ){
function_type=expression_function_type.ceiling  
}
(function_name_context.k_coalesce()  !=  unsafe { nil }  ){
function_type=expression_function_type.coalesce  
}
(function_name_context.k_convert()  !=  unsafe { nil }  ){
function_type=expression_function_type.convert  
}
(function_name_context.k_contains()  !=  unsafe { nil }  ){
function_type=expression_function_type.contains  
}
(function_name_context.k_dateadd()  !=  unsafe { nil }  ){
function_type=expression_function_type.date_add  
}
(function_name_context.k_datediff()  !=  unsafe { nil }  ){
function_type=expression_function_type.date_diff  
}
(function_name_context.k_datepart()  !=  unsafe { nil }  ){
function_type=expression_function_type.date_part  
}
(function_name_context.k_endswith()  !=  unsafe { nil }  ){
function_type=expression_function_type.ends_with  
}
(function_name_context.k_floor()  !=  unsafe { nil }  ){
function_type=expression_function_type.floor  
}
(function_name_context.k_iif()  !=  unsafe { nil }  ){
function_type=expression_function_type.iif  
}
(function_name_context.k_indexof()  !=  unsafe { nil }  ){
function_type=expression_function_type.index_of  
}
(function_name_context.k_isdate()  !=  unsafe { nil }  ){
function_type=expression_function_type.is_date  
}
(function_name_context.k_isinteger()  !=  unsafe { nil }  ){
function_type=expression_function_type.is_integer  
}
(function_name_context.k_isguid()  !=  unsafe { nil }  ){
function_type=expression_function_type.is_guid  
}
(function_name_context.k_isnull()  !=  unsafe { nil }  ){
function_type=expression_function_type.is_null  
}
(function_name_context.k_isnumeric()  !=  unsafe { nil }  ){
function_type=expression_function_type.is_numeric  
}
(function_name_context.k_lastindexof()  !=  unsafe { nil }  ){
function_type=expression_function_type.last_index_of  
}
(function_name_context.k_len()  !=  unsafe { nil }  ){
function_type=expression_function_type.len  
}
(function_name_context.k_lower()  !=  unsafe { nil }  ){
function_type=expression_function_type.lower  
}
(function_name_context.k_maxof()  !=  unsafe { nil }  ){
function_type=expression_function_type.max_of  
}
(function_name_context.k_minof()  !=  unsafe { nil }  ){
function_type=expression_function_type.min_of  
}
(function_name_context.k_now()  !=  unsafe { nil }  ){
function_type=expression_function_type.now  
}
(function_name_context.k_nthindexof()  !=  unsafe { nil }  ){
function_type=expression_function_type.nth_index_of  
}
(function_name_context.k_power()  !=  unsafe { nil }  ){
function_type=expression_function_type.power  
}
(function_name_context.k_regexmatch()  !=  unsafe { nil }  ){
function_type=expression_function_type.reg_ex_match  
}
(function_name_context.k_regexval()  !=  unsafe { nil }  ){
function_type=expression_function_type.reg_ex_val  
}
(function_name_context.k_replace()  !=  unsafe { nil }  ){
function_type=expression_function_type.replace  
}
(function_name_context.k_reverse()  !=  unsafe { nil }  ){
function_type=expression_function_type.reverse  
}
(function_name_context.k_round()  !=  unsafe { nil }  ){
function_type=expression_function_type.round  
}
(function_name_context.k_split()  !=  unsafe { nil }  ){
function_type=expression_function_type.split  
}
(function_name_context.k_sqrt()  !=  unsafe { nil }  ){
function_type=expression_function_type.sqrt  
}
(function_name_context.k_startswith()  !=  unsafe { nil }  ){
function_type=expression_function_type.starts_with  
}
(function_name_context.k_strcount()  !=  unsafe { nil }  ){
function_type=expression_function_type.str_count  
}
(function_name_context.k_strcmp()  !=  unsafe { nil }  ){
function_type=expression_function_type.str_cmp  
}
(function_name_context.k_substr()  !=  unsafe { nil }  ){
function_type=expression_function_type.sub_str  
}
(function_name_context.k_trim()  !=  unsafe { nil }  ){
function_type=expression_function_type.trim  
}
(function_name_context.k_trimleft()  !=  unsafe { nil }  ){
function_type=expression_function_type.trim_left  
}
(function_name_context.k_trimright()  !=  unsafe { nil }  ){
function_type=expression_function_type.trim_right  
}
(function_name_context.k_upper()  !=  unsafe { nil }  ){
function_type=expression_function_type.upper  
}
(function_name_context.k_utcnow()  !=  unsafe { nil }  ){
function_type=expression_function_type.utc_now  
}
else{
panic("unexpected function type \""  +  function_name_context.get_text()   +  "\""  ,)
}
}
mut expression_list:=context_10.expression_list()  
mut arguments:=[]Expression{} 
if expression_list  !=  unsafe { nil }  {
mut expression_list_context:=expression_list  
mut expressions:=expression_list_context.all_expression()  
mut argument_count:=expressions .len  
arguments=[]Expression{len: 0 }  
for i:=0  ;i  <  argument_count  ;i++ {
mut argument:=Expression{} 
if fep.try_get_expr(expressions[i ] ,& argument  ,) {
arguments <<argument   
}else {
panic("failed to find argument expression "  +  strconv.itoa(i ,)   +  " \""   +  expressions[i ].get_text()   +  "\" for function \""   +  function_name_context.get_text()   +  "\""  ,)
}
}
}else {
arguments=[]Expression{len: 0 }  
}
fep.add_expr(context_10 ,new_function_expression(function_type ,arguments ,) ,)
}

// GenerateExpressionTrees produces a set of expression trees for the provided filterExpression and data
pub fn generate_expression_trees(dataSet_1 &DataSet, primaryTable_2 string, filterExpression_2 string, suppressConsoleErrorOutput_2 bool) ([]&ExpressionTree, error, ) {mut parser,err_1:=new_filter_expression_parser_for_data_set(dataSet_1 ,filterExpression_2 ,primaryTable_2 ,unsafe { nil } ,suppressConsoleErrorOutput_2 ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
parser.track_filtered_rows=false  
return parser.expression_trees() 
}

// GenerateExpressionTreesFromTable produces a set of expression trees for the provided filterExpression and dataTa
pub fn generate_expression_trees_from_table(dataTable &DataTable, filterExpression_3 string, suppressConsoleErrorOutput_3 bool) ([]&ExpressionTree, error, ) {if dataTable  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("dataTable parameter is nil" ,) 
}
return generate_expression_trees(dataTable.parent() ,dataTable.name() ,filterExpression_3 ,suppressConsoleErrorOutput_3 ,) 
}

// GenerateExpressionTree gets the first produced expression tree for the provided filterExpression and dataTa
pub fn generate_expression_tree(dataTable_1 &DataTable, filterExpression_4 string, suppressConsoleErrorOutput_4 bool) (&ExpressionTree, error, ) {mut expression_trees_1,err_1:=generate_expression_trees_from_table(dataTable_1 ,filterExpression_4 ,suppressConsoleErrorOutput_4 ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
if expression_trees_1 .len  >  0  {
return expression_trees_1[0 ] ,unsafe { nil } 
}
return unsafe { nil } ,errors.new("no expression trees generated with filter expression \""  +  filterExpression_4   +  "\" for table \""   +  dataTable_1.name()   +  "\""  ,) 
}

// EvaluateExpression returns the result of the evaluated filterExpression. This expression evaluation function is 
pub fn evaluate_expression(filterExpression_5 string, suppressConsoleErrorOutput_5 bool) (&ValueExpression, error, ) {if filterExpression_5 .len  ==  0  {
return unsafe { nil } ,errors.new("filter expression is empty" ,) 
}
mut parser:=new_filter_expression_parser(filterExpression_5 ,suppressConsoleErrorOutput_5 ,)  
parser.track_filtered_rows=false  
mut expression_trees_1,err_1:=parser.expression_trees()  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
if expression_trees_1 .len  >  0  {
return expression_trees_1[0 ].evaluate(unsafe { nil } ,) 
}
return unsafe { nil } ,errors.new("no expression trees generated with filter expression \""  +  filterExpression_5   +  "\""  ,) 
}

// EvaluateDataRowExpression returns the result of the evaluated filterExpression using the specified data
pub fn evaluate_data_row_expression(dataRow &DataRow, filterExpression_6 string, suppressConsoleErrorOutput_6 bool) (&ValueExpression, error, ) {if dataRow  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("dataRow parameter is nil" ,) 
}
if filterExpression_6 .len  ==  0  {
return unsafe { nil } ,errors.new("filter expression is empty" ,) 
}
mut expression_tree,err_1:=generate_expression_tree(dataRow.parent() ,filterExpression_6 ,suppressConsoleErrorOutput_6 ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
return expression_tree.evaluate(dataRow ,) 
}

// SelectDataRows returns all rows matching the provided filterExpression and dataSet. Filter expressions
pub fn select_data_rows(dataSet_2 &DataSet, filterExpression_7 string, primaryTable_3 string, tableIDFields_1 &TableIDFields, suppressConsoleErrorOutput_7 bool) ([]&DataRow, error, ) {mut parser,err_1:=new_filter_expression_parser_for_data_set(dataSet_2 ,filterExpression_7 ,primaryTable_3 ,tableIDFields_1 ,suppressConsoleErrorOutput_7 ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
mut err_2:=parser.evaluate(true ,true ,) 
if err_2  !=  unsafe { nil }  {
return unsafe { nil } ,err_2 
}
return parser.filtered_rows() ,unsafe { nil } 
}

// SelectDataRowsFromTable returns all rows matching the provided filterExpression and dataTable. Fi
pub fn select_data_rows_from_table(dataTable_2 &DataTable, filterExpression_8 string, primaryTable_4 string, tableIDFields_2 &TableIDFields, suppressConsoleErrorOutput_8 bool) ([]&DataRow, error, ) {if dataTable_2  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("dataTable parameter is nil" ,) 
}
return select_data_rows(dataTable_2.parent() ,filterExpression_8 ,dataTable_2.name() ,tableIDFields_2 ,suppressConsoleErrorOutput_8 ,) 
}

// SelectDataRowSet returns all unique rows matching the provided filterExpression and dataSet. Fi
pub fn select_data_row_set(dataSet_3 &DataSet, filterExpression_9 string, primaryTable_5 string, tableIDFields_3 &TableIDFields, suppressConsoleErrorOutput_9 bool) (hashset.HashSet, error, ) {mut parser,err_1:=new_filter_expression_parser_for_data_set(dataSet_3 ,filterExpression_9 ,primaryTable_5 ,tableIDFields_3 ,suppressConsoleErrorOutput_9 ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
mut err_2:=parser.evaluate(true ,false ,) 
if err_2  !=  unsafe { nil }  {
return unsafe { nil } ,err_2 
}
return parser.filtered_row_set() ,unsafe { nil } 
}

// SelectDataRowSetFromTable returns all unique rows matching the provided filterExpression and dataTa
pub fn select_data_row_set_from_table(dataTable_3 &DataTable, filterExpression_10 string, tableIDFields_4 &TableIDFields, suppressConsoleErrorOutput_10 bool) (hashset.HashSet, error, ) {if dataTable_3  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("dataTable parameter is nil" ,) 
}
return select_data_row_set(dataTable_3.parent() ,filterExpression_10 ,dataTable_3.name() ,tableIDFields_4 ,suppressConsoleErrorOutput_10 ,) 
}

// SelectSignalIDSet returns all unique Guid signal IDs matching the provided filterExpression and data
pub fn select_signal_idset(dataSet_4 &DataSet, filterExpression_11 string, primaryTable_6 string, tableIDFields_5 &TableIDFields, suppressConsoleErrorOutput_11 bool) (hashset.HashSet, error, ) {mut parser,err_1:=new_filter_expression_parser_for_data_set(dataSet_4 ,filterExpression_11 ,primaryTable_6 ,tableIDFields_5 ,suppressConsoleErrorOutput_11 ,)  
if err_1  !=  unsafe { nil }  {
return unsafe { nil } ,err_1 
}
parser.track_filtered_rows=false  
parser.track_filtered_signal_ids=true  
mut err_2:=parser.evaluate(true ,false ,) 
if err_2  !=  unsafe { nil }  {
return unsafe { nil } ,err_2 
}
return parser.filtered_signal_idset() ,unsafe { nil } 
}

// SelectSignalIDSetFromTable returns all unique Guid signal IDs matching the provided filterExpression
pub fn select_signal_idset_from_table(dataTable_4 &DataTable, filterExpression_12 string, primaryTable_7 string, tableIDFields_6 &TableIDFields, suppressConsoleErrorOutput_12 bool) (hashset.HashSet, error, ) {if dataTable_4  ==  unsafe { nil }  {
return unsafe { nil } ,errors.new("dataTable parameter is nil" ,) 
}
return select_signal_idset(dataTable_4.parent() ,filterExpression_12 ,dataTable_4.name() ,tableIDFields_6 ,suppressConsoleErrorOutput_12 ,) 
}
