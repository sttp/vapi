module xml
import encoding.xml
import os
import strings
struct XmlDocument {
mut:
root XmlNode 
max_level int 
}
fn (mut xd XmlDocument) traverse(nodes []XmlNode, parent &XmlNode) {mut length:=nodes .len  
parent.item=map[string]*XmlNode{len: length }  
parent.items=map[string][]*XmlNode {len: length }  
for i:=0  ;i  <  length  ;i++ {
mut level:=parent.level  +  1   
if level  >  xd.max_level  {
xd.max_level=level  
}
mut node:=& nodes[i ]   
node.name=node.xmlname.local  
node.namespace=node.xmlname.space  
node.parent=parent  
node.level=level  
node.owner=xd  
mut _,found:=parent.item[node.name ] 
if ! found  {
parent.item[node.name ]=node  
parent.items[node.name ]=[node ]  
}else {
parent.items[node.name ] <<node   
}
if i  >  0  {
node.previous=& nodes[i  -  1  ]   
node.previous.next=node  
}
xd.traverse(node.child_nodes ,node ,)
}
}

// UnmarshalXML decodes a single XML element beginning with the given start elem
pub fn (mut xn XmlNode) unmarshal_xml(d &xml.Decoder, start xml.StartElement) (error, ) {xn.attributes=map[string]string{len: start.attr .len }  
xn.attribute_namespaces=map[string]string{len: start.attr .len }  
for _, v in  start.attr  {
xn.attributes[v.name.local ]=v.value  
xn.attribute_namespaces[v.name.local ]=v.name.space  
}

return d.decode_element(*node(xn ,) ,& start  ,) 
}

// LoadXml loads the XmlDocument from the specified XML d
pub fn (mut xd XmlDocument) load_xml(data []u8) (error, ) {mut buffer:=bytes.new_buffer(data ,)  
mut decoder:=xml.new_decoder(buffer ,)  
mut err:=decoder.decode(& xd.root  ,)  
if err  !=  unsafe { nil }  {
return err 
}
xd.root.name=xd.root.xmlname.local  
xd.root.namespace=xd.root.xmlname.space  
xd.root.owner=xd  
xd.traverse(xd.root.child_nodes ,& xd.root  ,)
return unsafe { nil } 
}

// LoadXmlFromFile loads the XmlDocument from the specified file name containing XML d
pub fn (mut xd XmlDocument) load_xml_from_file(fileName string) (error, ) {mut data_1,err:=os.read_file(fileName ,)  
if err  !=  unsafe { nil }  {
return err 
}
return xd.load_xml(data_1 ,) 
}

// MaxDepth gets the maximum node depth for XmlNode instances in this XmlDocument t
pub fn (mut xd XmlDocument) max_depth() (int, ) {return xd.max_level  +  1  
}

// SelectNodes finds all nodes matching xpath expression starting at XmlDocument r
pub fn (mut xd XmlDocument) select_nodes(xpath string) ([]&XmlNode, ) {if strings.has_prefix(xpath ,"//" ,)  &&  strings.has_prefix(xpath[2 .. ] ,xd.root.name  +  "/"  ,)  {
return xd.root.select_nodes(xpath[3  +  xd.root.name .len  .. ] ,) 
}
return xd.root.select_nodes(xpath ,) 
}
