module xml

const (
	doc                           = XmlDocument{}
	xml_schema_namespace          = 'http://www.w3.org/2001/XMLSchema'
	ext_xml_schema_data_namespace = 'urn:schemas-microsoft-com:xml-msdata'
)

fn init() {
	xml.doc.load_xml_from_file('../../test/SampleMetadata.xml')
}

pub fn test_root_level(t &testing.T) {
	if xml.doc.root.level != 0 {
		t.fatalf('Root level in document tree should be zero')
	}
}

pub fn test_value(t_1 &testing.T) {
	mut schema_version := xml.doc.root.item['SchemaVersion']
	mut version_number := schema_version.item['VersionNumber'].value()
	if version_number != '9' {
		t_1.fatalf('SampleMetadata.xml expected to have schema version of 9, received: %s',
			version_number)
	}
}

pub fn test_path(t_2 &testing.T) {
	mut schema_version := xml.doc.root.item['SchemaVersion']
	mut version_number_path := schema_version.item['VersionNumber'].path()
	if version_number_path != '//DataSet/SchemaVersion/VersionNumber' {
		t_2.fatalf('SampleMetadata.xml expected to have schema version number path of "//DataSet/SchemaVersion/VersionNumber", received: %s',
			version_number_path)
	}
}

pub fn test_prefix(t_3 &testing.T) {
	mut schema := xml.doc.root.item['schema']
	mut prefix := schema.prefix()
	if prefix != 'xs' {
		t_3.fatalf('SampleMetadata.xml expected to have schema prefix of "xs", received: "%s"',
			prefix)
	}
}

pub fn test_child_node_load(t_4 &testing.T) {
	mut root := xml.doc.root
	if !root.has_child_nodes() {
		t_4.fatalf('SampleMetadata.xml expected to have child nodes')
	}
	if root.child_nodes.len != 138 {
		t_4.fatalf('SampleMetadata.xml expected to have 138 root child nodes')
	}
}

pub fn test_max_depth_load(t_5 &testing.T) {
	if xml.doc.max_depth() != 9 {
		t_5.fatalf('SampleMetadata.xml expected to have max depth of 9')
	}
}

pub fn test_namespace_load(t_6 &testing.T) {
	mut schema := xml.doc.root.item['schema']
	if schema.namespace != xml.xml_schema_namespace {
		t_6.fatalf('SampleMetadata.xml expected to have schema namespace of "%s", received: "%s"',
			xml.xml_schema_namespace, schema.namespace)
	}
}

pub fn test_attributes_load(t_7 &testing.T) {
	mut schema := xml.doc.root.item['schema']
	mut id, found := schema.attributes['id']
	if !found {
		t_7.fatalf('SampleMetadata.xml "schema" element expected to have attribute "id" = "DataSet", found none')
	}
	if id != 'DataSet' {
		t_7.fatalf('SampleMetadata.xml "schema" element expected to have attribute "id" = "DataSet", received: "%s"',
			id)
	}
	if schema.attributes.len != 3 {
		t_7.fatalf('SampleMetadata.xml "schema" element expected to have 3 attributes, received: %d',
			schema.attributes.len)
	}
}

pub fn test_attribute_namespaces_load(t_8 &testing.T) {
	mut schema := xml.doc.root.item['schema']
	mut table_nodes := schema.select_nodes('element/complexType/choice/element')
	mut guid_field_nodes := select_nodes(table_nodes, "complexType/sequence/element[@DataType='System.Guid']")
	if guid_field_nodes.len != 3 {
		t_8.fatalf('SampleMetadata.xml schema expected to contain 3 fields with Guid type, received: %d',
			guid_field_nodes.len)
	}
	for _, node in guid_field_nodes {
		mut namespace, found := node.attribute_namespaces['DataType']
		if found {
			if namespace != xml.ext_xml_schema_data_namespace {
				t_8.fatalf('SampleMetadata.xml Guid type fields expected to have namespace of "%s", received: "%s"',
					xml.ext_xml_schema_data_namespace, namespace)
			}
		} else {
			t_8.fatalf('SampleMetadata.xml failed to find attribute namespace for Guid type in field node: "%s"',
				node.name)
		}
	}
}

pub fn test_select_nodes(t_9 &testing.T) {
	mut nodes := xml.doc.select_nodes('schema/element/complexType/choice/element')
	if nodes.len != 4 {
		t_9.fatalf('SampleMetadata.xml schema expected to contain 4 table definitions, received: %d',
			nodes.len)
	}
}

pub fn test_select_nodes_from_root(t_10 &testing.T) {
	mut table_nodes := xml.doc.select_nodes('//DataSet/schema/element/complexType/choice/element')
	if table_nodes.len != 4 {
		t_10.fatalf('SampleMetadata.xml schema expected to contain 4 table definitions, received: %d',
			table_nodes.len)
	}
	mut records := xml.doc.select_nodes('SchemaVersion[VersionNumber]')
	if records.len != 1 {
		t_10.fatalf('SampleMetadata.xml schema expected to contain 1 SchemaVersion record, received: %d',
			records.len)
	}
}

pub fn test_select_nodes_with_wildcards(t_11 &testing.T) {
	mut schema := xml.doc.root.item['schema']
	mut table_nodes := schema.select_nodes('element/complexType/choice/*')
	if table_nodes.len != 4 {
		t_11.fatalf('SampleMetadata.xml schema expected to contain 4 table definitions, received: %d',
			table_nodes.len)
	}
	mut guid_field_nodes := select_nodes(table_nodes, 'complexType/sequence/*[@DataType]')
	if guid_field_nodes.len != 3 {
		t_11.fatalf('SampleMetadata.xml schema expected to contain 3 fields with Guid type, received: %d',
			guid_field_nodes.len)
	}
	guid_field_nodes = select_nodes(table_nodes, "complexType/sequence/element[@*='System.Guid']")
	if guid_field_nodes.len != 3 {
		t_11.fatalf('SampleMetadata.xml schema expected to contain 3 fields with Guid type, received: %d',
			guid_field_nodes.len)
	}
	mut records := xml.doc.select_nodes('SchemaVersion[*]')
	if records.len != 1 {
		t_11.fatalf('SampleMetadata.xml schema expected to contain 1 SchemaVersion record, received: %d',
			records.len)
	}
}

pub fn test_select_nodes_with_sub_expr_predicate_attributes(t_12 &testing.T) {
	mut schema := xml.doc.root.item['schema']
	mut guid_field_nodes := schema.select_nodes("element/complexType/choice/element/complexType/sequence/element[@DataType='System.Guid']")
	if guid_field_nodes.len != 3 {
		t_12.fatalf('SampleMetadata.xml schema expected to contain 3 fields with Guid type, received: %d',
			guid_field_nodes.len)
	}
}

pub fn test_item_load(t_13 &testing.T) {
	_, found := xml.doc.root.item['SchemaVersion']
	if !found {
		t_13.fatalf('SampleMetadata.xml expected to have "SchemaVersion" node, found none')
	}
}

pub fn test_items_load(t_14 &testing.T) {
	mut root := xml.doc.root
	mut node := root.first_child()
	mut last_node_name := ''
	mut name_count := 0
	for node != unsafe { nil } {
		if last_node_name != node.name {
			if last_node_name.len > 0 {
				if name_count != root.items[last_node_name].len {
					t_14.fatalf('Items count for "%s" elements is %d, expected %d', last_node_name,
						root.items[last_node_name].len, name_count)
				}
			}
			println(node.name)
			last_node_name = node.name
			name_count = 1
		} else {
			name_count++
		}
		node = node.next
	}
}

pub fn test_reverse_enumeration(t_15 &testing.T) {
	mut node := xml.doc.root.last_child()
	mut count := 0
	for node != unsafe { nil } {
		count++
		node = node.previous
	}
	if count != 138 {
		t_15.fatalf('SampleMetadata.xml expected to have 138 root child nodes')
	}
}
