module data
import github.com.shopspring.decimal
const minus_one_dec=decimal.Decimal(decimal.new_from_int(- 1  ,) )
struct UnaryExpression {
mut:
value Expression 
unary_type ExpressionUnaryTypeEnum 
}
// NewUnaryExpression creates a new unary express
pub fn new_unary_expression(unaryType ExpressionUnaryTypeEnum, value Expression) (&UnaryExpression, ) {return & UnaryExpression{
value:value  ,
unaryType:unaryType  }  
}

// Type gets expression type of the UnaryExpress
pub fn (mut _ UnaryExpression) @type() (ExpressionTypeEnum, ) {return expression_type.unary 
}

// Value gets the expression value of the UnaryExpress
pub fn (mut ue UnaryExpression) value_1() (Expression, ) {return ue.value 
}

// UnaryType gets unary type of the UnaryExpress
pub fn (mut ue UnaryExpression) unary_type() (ExpressionUnaryTypeEnum, ) {return ue.unary_type 
}

fn (mut ue UnaryExpression) unary_boolean(value_3 bool) (&ValueExpression, error, ) { match ue.unary_type {expression_unary_type.not {
value_3=! value_3   
}
expression_unary_type.plus {
return unsafe { nil } ,errors.new("cannot apply unary \"+\" operator to \"Boolean\"" ,) 
}
expression_unary_type.minus {
return unsafe { nil } ,errors.new("cannot apply unary \"-\" operator to \"Boolean\"" ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected unary type encountered" ,) 
}
}
return new_value_expression(expression_value_type.boolean ,value_3 ,) ,unsafe { nil } 
}

fn (mut ue UnaryExpression) unary_int32(value_3 i32) (&ValueExpression, error, ) { match ue.unary_type {expression_unary_type.plus {
value_3= value_3   
}
expression_unary_type.minus {
value_3=- value_3   
}
expression_unary_type.not {
value_3=^ value_3   
}
else{
return unsafe { nil } ,errors.new("unexpected unary type encountered" ,) 
}
}
return new_value_expression(expression_value_type.int32 ,value_3 ,) ,unsafe { nil } 
}

fn (mut ue UnaryExpression) unary_int64(value_3 i64) (&ValueExpression, error, ) { match ue.unary_type {expression_unary_type.plus {
value_3= value_3   
}
expression_unary_type.minus {
value_3=- value_3   
}
expression_unary_type.not {
value_3=^ value_3   
}
else{
return unsafe { nil } ,errors.new("unexpected unary type encountered" ,) 
}
}
return new_value_expression(expression_value_type.int64 ,value_3 ,) ,unsafe { nil } 
}

fn (mut ue UnaryExpression) unary_decimal(value_3 decimal.Decimal) (&ValueExpression, error, ) { match ue.unary_type {expression_unary_type.plus {
}
expression_unary_type.minus {
value_3=value_3.mul(minus_one_dec ,)  
}
expression_unary_type.not {
return unsafe { nil } ,errors.new("cannot apply unary \"~\" operator to \"Decimal\"" ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected unary type encountered" ,) 
}
}
return new_value_expression(expression_value_type.decimal ,value_3 ,) ,unsafe { nil } 
}

fn (mut ue UnaryExpression) unary_double(value_3 f64) (&ValueExpression, error, ) { match ue.unary_type {expression_unary_type.plus {
value_3= value_3   
}
expression_unary_type.minus {
value_3=- value_3   
}
expression_unary_type.not {
return unsafe { nil } ,errors.new("cannot apply unary \"~\" operator to \"Double\"" ,) 
}
else{
return unsafe { nil } ,errors.new("unexpected unary type encountered" ,) 
}
}
return new_value_expression(expression_value_type.double ,value_3 ,) ,unsafe { nil } 
}
