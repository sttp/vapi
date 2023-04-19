module xml
import encoding.xml
import strings
struct XmlNode {
mut:
xmlname xml.Name 
name string 
namespace string 
inner_xml []u8 
child_nodes []XmlNode 
parent &XmlNode  = nil 
next &XmlNode  = nil 
previous &XmlNode  = nil 
attributes map[string]string 
attribute_namespaces map[string]string 
item map[string]&XmlNode 
items map[string][]*XmlNode  
level int 
owner &XmlDocument 
}
// Path gets the full path of this node within its XmlDocument t
pub fn (mut xn XmlNode) path() (string, ) {mut paths:=[]string{} 
mut node:=xn  
for node  !=  unsafe { nil }  {
paths <<node.name   
node=node.parent  
}
mut path_1:=strings.Builder{} 
path_1.write_rune(`/` ,)
for i:=paths .len  -  1   ;i  >  - 1   ;i-- {
path_1.write_rune(`/` ,)
path_1.write_string(paths[i ] ,)
}
return path_1.string() 
}

// Value gets the InnerXml of this node as a str
pub fn (mut xn XmlNode) value() (string, ) {return xn.inner_xml .str() 
}

// Prefix looks up namespace prefix for this n
pub fn (mut xn XmlNode) prefix() (string, ) {mut namespace:=xn.namespace  
for name, value_1 in  xn.attributes  {
if value_1  ==  namespace  {
return name 
}
}
return "" 
}

// HasChildNodes gets a flag indicating if this node has any child no
pub fn (mut xn XmlNode) has_child_nodes() (bool, ) {return xn.child_nodes .len  >  0  
}

// FirstChild gets the first child of this node, or nil if there are no child no
pub fn (mut xn XmlNode) first_child() (&XmlNode, ) {if xn.has_child_nodes() {
return & xn.child_nodes[0 ]  
}
return unsafe { nil } 
}

// LastChild gets the last child of this node, or nil if there are not child no
pub fn (mut xn XmlNode) last_child() (&XmlNode, ) {if xn.has_child_nodes() {
return & xn.child_nodes[xn.child_nodes .len  -  1  ]  
}
return unsafe { nil } 
}

// GetChildNodes gets a slice of pointers to all child nodes of this n
pub fn (mut xn XmlNode) get_child_nodes() ([]&XmlNode, ) {mut count:=xn.child_nodes .len  
mut child_nodes:=[]*XmlNode{len: count }  
for i:=0  ;i  <  count  ;i++ {
child_nodes[i ]=& xn.child_nodes[i ]   
}
return child_nodes 
}

// SelectNodes finds all nodes matching xpath expression for each input n
pub fn select_nodes(nodes []&XmlNode, xpath string) ([]&XmlNode, ) {mut results:=[]*XmlNode{len: 0 }  
for _, node in  nodes  {
results <<node.select_nodes(xpath ,)   
}
return results 
}

fn is_match(value_1 string) (bool, ) {return value_1  ==  name   ||  name  ==  "*"   
}

// SelectNodes finds all nodes matching xpath express
pub fn (mut xn XmlNode) select_nodes_1(xpath_1 string) ([]&XmlNode, ) {mut nodes_1:=xn.get_child_nodes()  
mut exprs:=xpath_1 .split("/" ,)  
mut results:=[]&XmlNode{} 
for i:=0  ;i  <  exprs .len  ;i++ {
mut expr:=exprs[i ]  
results=[]*XmlNode{len: 0 }  
for _, node in  nodes_1  {
mut lbp:=strings.index_rune(expr ,`[` ,)  
mut rbp:=strings.index_rune(expr ,`]` ,)  
if lbp  >  - 1    &&  rbp  >  - 1     &&  rbp  >  lbp    &&  expr .len  >  2   {
mut name:=expr[ ..lbp ]  
mut predicate:=expr[lbp  +  1  ..rbp ]  
if predicate[0 ]  ==  `@`  {
if is_match(node.name ,name ,)  &&  node.attribute_match(predicate[1 .. ] ,)  {
results <<node   
}
}else {
if is_match(node.name ,name ,)  &&  node.child_value_match(predicate ,)  {
results <<node   
}
}
}else if is_match(node.name ,expr ,) {
results <<node   
}
}
if results .len  ==  0  {
break 
}
if i  <  exprs .len  -  1   {
nodes_1=[]*XmlNode{len: 0 }  
for _, result in  results  {
nodes_1 <<result.get_child_nodes()   
}
}
}
return results 
}

fn remove_quotes(value_1 string) (string, ) {if strings.has_prefix(value_1 ,"'" ,)  &&  strings.has_suffix(value_1 ,"'" ,)   &&  value_1 .len  >  2   {
value_1=value_1[1 ..value_1 .len  -  1  ]  
}
return value_1 
}

fn (mut xn XmlNode) attribute_match(expr string) (bool, ) {mut parts:=expr .split("=" ,)  
for i:=0  ;i  <  parts .len  ;i++ {
parts[i ]=parts[i ] .trim_space()  
}
if parts[0 ]  ==  "*"  {
if parts .len  ==  1  {
return true 
}
for _, value_1 in  xn.attributes  {
if value_1  ==  remove_quotes(parts[1 ] ,)  {
return true 
}
}
}else {
mut value_1,found:=xn.attributes[parts[0 ] ] 
if found {
if parts .len  ==  2  {
return value_1  ==  remove_quotes(parts[1 ] ,)  
}
return true 
}
}
return false 
}

fn (mut xn XmlNode) child_value_match(expr_1 string) (bool, ) {for _, node in  xn.get_child_nodes()  {
if node.value_match(expr_1 ,) {
return true 
}
}
return false 
}

fn (mut xn XmlNode) value_match(expr_2 string) (bool, ) {mut parts:=expr_2 .split("=" ,)  
for i:=0  ;i  <  parts .len  ;i++ {
parts[i ]=parts[i ] .trim_space()  
}
if parts[0 ]  ==  xn.name   ||  parts[0 ]  ==  "*"   {
if parts .len  ==  2  {
return xn.value()  ==  remove_quotes(parts[1 ] ,)  
}
return true 
}
return false 
}
