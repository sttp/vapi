module data

const default_table_idfields = &TableIDFields{
	signal_idfield_name: 'SignalID'
	measurement_key_field_name: 'ID'
	point_tag_field_name: 'PointTag'
}

struct TableIDFields {
mut:
	signal_idfield_name        string
	measurement_key_field_name string
	point_tag_field_name       string
}
