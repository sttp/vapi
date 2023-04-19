module data
import strconv
import strings
import time
import github.com.shopspring.decimal
import github.com.sttp.goapi.sttp.guid
import github.com.sttp.goapi.sttp.xml
const (
xml_schema_namespace="http://www.w3.org/2001/XMLSchema" 
ext_xml_schema_data_namespace="urn:schemas-microsoft-com:xml-msdata" 
date_time_format="2006-01-02T15:04:05.99-07:00" 
)
struct DataSet {
mut:
tables map[string]&DataTable 
name string 
}
// NewDataSet creates a new Data
pub fn new_data_set() (&DataSet, ) {return & DataSet{
tables:map[string]*DataTable{}  ,
name:"DataSet"  }  
}

// AddTable adds the specified table to the Data
pub fn (mut ds DataSet) add_table(table &DataTable) {ds.tables[table.name() .to_upper() ]=table  
}

// Table gets the DataTable for the specified tableName if the name exi
pub fn (mut ds DataSet) table_1(tableName string) (&DataTable, ) {mut table_3,ok:=ds.tables[tableName .to_upper() ] 
if ok {
return table_3 
}
return unsafe { nil } 
}

// TableNames gets the table names defined in the Data
pub fn (mut ds DataSet) table_names() ([]string, ) {mut table_names_1:=[]string{len: 0 }  
for _, table_3 in  ds.tables  {
table_names_1 <<table_3.name()   
}
return table_names_1 
}

// Tables gets the DataTable instances defined in the Data
pub fn (mut ds DataSet) tables() ([]&DataTable, ) {mut tables_1:=[]*DataTable{len: 0 }  
for _, table_3 in  ds.tables  {
tables_1 <<table_3   
}
return tables_1 
}

// CreateTable creates a new DataTable associated with the Data
pub fn (mut ds DataSet) create_table(name string) (&DataTable, ) {return new_data_table(ds ,name ,) 
}

// TableCount gets the total number of tables defined in the Data
pub fn (mut ds DataSet) table_count() (int, ) {return ds.tables .len 
}

// RemoveTable removes the specified tableName from the DataSet. Ret
pub fn (mut ds DataSet) remove_table(tableName_1 string) (bool, ) {tableName_1=tableName_1 .to_upper()  
mut _,ok:=ds.tables[tableName_1 ] 
if ok {
ds.tables .delete(tableName_1 ,)
return true 
}
return false 
}

// String get a representation of the DataSet as a str
pub fn (mut ds DataSet) string() (string, ) {mut image:=strings.Builder{} 
image.write_string(ds.name ,)
image.write_string(" [" ,)
mut i:=0  
for _, table_3 in  ds.tables  {
if i  >  0  {
image.write_string(", " ,)
}
image.write_string(table_3.name() ,)
i++
}
image.write_rune(`]` ,)
return image.string() 
}

// ParseXml loads the DataSet from the XML in the specified buf
pub fn (mut ds DataSet) parse_xml(data []u8) (error, ) {mut doc:=xml.XmlDocument{} 
mut err:=doc.load_xml(data ,) 
if err  !=  unsafe { nil }  {
return err 
}
return ds.parse_xml_document(& doc  ,) 
}

// ParseXmlDocument loads the DataSet from an existing XmlDocum
pub fn (mut ds DataSet) parse_xml_document(doc &xml.XmlDocument) (error, ) {mut root:=doc.root  
mut schema,found:=root.item["schema" ]  
if ! found  {
return errors.new("failed to parse DataSet XML: Cannot find schema node" ,) 
}
mut id,found_1:=schema.attributes["id" ]  
if ! found_1   ||  id  !=  root.name   {
return errors.new("failed to parse DataSet XML: Cannot find schema node matching \""  +  root.name   +  "\""  ,) 
}
if schema.namespace  !=  xml_schema_namespace  {
return errors.new("failed to parse DataSet XML: cannot find schema namespace \""  +  xml_schema_namespace   +  "\""  ,) 
}
ds.load_schema(schema ,)
ds.load_records(& root  ,)
return unsafe { nil } 
}

//gocyclo:ig
fn (mut ds DataSet) load_schema(schema &xml.XmlNode) {mut schema_prefix:=schema.prefix()  
if schema_prefix .len  >  0  {
schema_prefix+=":"  
}
mut table_nodes:=schema.select_nodes("element/complexType/choice/element" ,)  
for _, table_node in  table_nodes  {
mut table_name,found:=table_node.attributes["name" ]  
if ! found   ||  table_name .len  ==  0   {
continue 
}
mut data_table:=ds.create_table(table_name ,)  
mut field_nodes:=table_node.select_nodes("complexType/sequence/element" ,)  
data_table.init_columns(field_nodes .len ,)
for _, field_node in  field_nodes  {
mut field_name,found_1:=field_node.attributes["name" ]  
if ! found_1   ||  field_name .len  ==  0   {
continue 
}
mut type_name,found_2:=field_node.attributes["type" ]  
if ! found_2   ||  type_name .len  ==  0   {
continue 
}
type_name=type_name .trim_prefix(schema_prefix ,)  
mut ext_data_type,found_3:=field_node.attributes["DataType" ]  
if found_3  &&  ext_data_type .len  >  0   {
if field_node.attribute_namespaces["DataType" ]  !=  ext_xml_schema_data_namespace  {
ext_data_type=""  
}
}
mut data_type,found_4:=parse_xsd_data_type(type_name ,ext_data_type ,)  
if ! found_4  {
continue 
}
mut expression,found_5:=field_node.attributes["Expression" ]  
if found_5  &&  expression .len  >  0   {
if field_node.attribute_namespaces["Expression" ]  !=  ext_xml_schema_data_namespace  {
expression=""  
}
}
mut data_column:=data_table.create_column(field_name ,data_type ,expression ,)  
data_table.add_column(data_column ,)
}
ds.add_table(data_table ,)
}
}

//gocyclo:ig
fn (mut ds DataSet) load_records(root &xml.XmlNode) {for _, table_3 in  ds.tables()  {
mut records:=root.items[table_3.name() ]  
table_3.init_rows(records .len ,)
for _, record in  records  {
mut data_row:=table_3.create_row()  
for _, field in  record.child_nodes  {
mut column:=table_3.column_by_name(field.name ,)  
if column  ==  unsafe { nil }  {
continue 
}
mut column_index:=column.index()  
mut value:=field.value()  
 match column.@type() {data_type.string {
data_row.set_value(column_index ,value ,)
}
data_type.boolean {
data_row.set_value(column_index ,value  ==  "true"  ,)
}
data_type.date_time {
mut dt,_:=time.parse(date_time_format ,value ,)  
data_row.set_value(column_index ,dt ,)
}
data_type.single {
mut f32,_:=strconv.parse_float(value ,32 ,)  
data_row.set_value(column_index ,f32(f32 ,) ,)
}
data_type.double {
mut f64,_:=strconv.parse_float(value ,64 ,)  
data_row.set_value(column_index ,f64 ,)
}
data_type.decimal {
mut d,_:=decimal.new_from_string(value ,)  
data_row.set_value(column_index ,d ,)
}
data_type.guid {
mut g,_:=guid.parse(value ,)  
data_row.set_value(column_index ,g ,)
}
data_type.int8 {
mut i8,_:=strconv.parse_int(value ,0 ,8 ,)  
data_row.set_value(column_index ,i8(i8 ,) ,)
}
data_type.int16 {
mut i16,_:=strconv.parse_int(value ,0 ,16 ,)  
data_row.set_value(column_index ,i16(i16 ,) ,)
}
data_type.int32 {
mut i32,_:=strconv.parse_int(value ,0 ,32 ,)  
data_row.set_value(column_index ,i32(i32 ,) ,)
}
data_type.int64 {
mut i64,_:=strconv.parse_int(value ,0 ,64 ,)  
data_row.set_value(column_index ,i64 ,)
}
data_type.uint8 {
mut ui8,_:=strconv.parse_uint(value ,0 ,8 ,)  
data_row.set_value(column_index ,u8(ui8 ,) ,)
}
data_type.uint16 {
mut ui16,_:=strconv.parse_uint(value ,0 ,16 ,)  
data_row.set_value(column_index ,u16(ui16 ,) ,)
}
data_type.uint32 {
mut ui32,_:=strconv.parse_uint(value ,0 ,32 ,)  
data_row.set_value(column_index ,u32(ui32 ,) ,)
}
data_type.uint64 {
mut ui64,_:=strconv.parse_uint(value ,0 ,64 ,)  
data_row.set_value(column_index ,ui64 ,)
}
else{
}
}
}
table_3.add_row(data_row ,)
}
}
}

// FromXml creates a new DataSet as read from the XML in the specified buf
pub fn from_xml(buffer []u8) (&DataSet, ) {mut data_set:=new_data_set()  
data_set.parse_xml(buffer ,)
return data_set 
}
