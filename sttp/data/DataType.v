module data

import strings

const data_type = NOT_YET_IMPLEMENTED

type DataTypeEnum = int

struct Go2VInlineStruct {
mut:
	string    DataTypeEnum
	boolean   DataTypeEnum
	date_time DataTypeEnum
	single    DataTypeEnum
	double    DataTypeEnum
	decimal   DataTypeEnum
	guid      DataTypeEnum
	i8        DataTypeEnum
	i16       DataTypeEnum
	i32       DataTypeEnum
	i64       DataTypeEnum
	u8        DataTypeEnum
	u16       DataTypeEnum
	u32       DataTypeEnum
	u64       DataTypeEnum
}

// String gets the DataType enumeration name as a str
pub fn (mut dte DataTypeEnum) string() string {
	match dte {
		data.data_type.string {
			return 'String'
		}
		data.data_type.boolean {
			return 'Boolean'
		}
		data.data_type.date_time {
			return 'DateTime'
		}
		data.data_type.single {
			return 'Single'
		}
		data.data_type.double {
			return 'Double'
		}
		data.data_type.decimal {
			return 'Decimal'
		}
		data.data_type.guid {
			return 'Guid'
		}
		data.data_type.int8 {
			return 'Int8'
		}
		data.data_type.int16 {
			return 'Int16'
		}
		data.data_type.int32 {
			return 'Int32'
		}
		data.data_type.int64 {
			return 'Int64'
		}
		data.data_type.uint8 {
			return 'UInt8'
		}
		data.data_type.uint16 {
			return 'UInt16'
		}
		data.data_type.uint32 {
			return 'UInt32'
		}
		data.data_type.uint64 {
			return 'UInt64'
		}
		else {
			return 'Undefined'
		}
	}
}

// ParseXsdDataType gets the DataType from the provided XSD data type. Return tuple incl
pub fn parse_xsd_data_type(xsdTypeName string) (DataTypeEnum, bool) {
	match xsdTypeName {
		'string' {
			if strings.has_prefix(ext_data_type, 'System.Guid') {
				return data.data_type.guid, true
			}
			return data.data_type.string, true
		}
		'boolean' {
			return data.data_type.boolean, true
		}
		'dateTime' {
			return data.data_type.date_time, true
		}
		'float' {
			return data.data_type.single, true
		}
		'double' {
			return data.data_type.double, true
		}
		'decimal' {
			return data.data_type.decimal, true
		}
		'byte' {
			return data.data_type.int8, true
		}
		'short' {
			return data.data_type.int16, true
		}
		'int' {
			return data.data_type.int32, true
		}
		'long' {
			return data.data_type.int64, true
		}
		'unsignedByte' {
			return data.data_type.uint8, true
		}
		'unsignedShort' {
			return data.data_type.uint16, true
		}
		'unsignedInt' {
			return data.data_type.uint32, true
		}
		'unsignedLong' {
			return data.data_type.uint64, true
		}
		else {
			return data.data_type.string, false
		}
	}
}
