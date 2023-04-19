module transport

import strconv
import strings
import encoding

const signal_kind = NOT_YET_IMPLEMENTED

type SignalKindEnum = u16

struct Go2VInlineStruct {
mut:
	angle       SignalKindEnum
	magnitude   SignalKindEnum
	frequency   SignalKindEnum
	df_dt       SignalKindEnum
	status      SignalKindEnum
	digital     SignalKindEnum
	analog      SignalKindEnum
	calculation SignalKindEnum
	statistic   SignalKindEnum
	alarm       SignalKindEnum
	quality     SignalKindEnum
	unknown     SignalKindEnum
}

// String gets the SignalKind enumeration value as a str
pub fn (mut ske SignalKindEnum) string() string {
	match ske {
		transport.signal_kind.angle {
			return 'Angle'
		}
		transport.signal_kind.magnitude {
			return 'Magnitude'
		}
		transport.signal_kind.frequency {
			return 'Frequency'
		}
		transport.signal_kind.df_dt {
			return 'DfDt'
		}
		transport.signal_kind.status {
			return 'Status'
		}
		transport.signal_kind.digital {
			return 'Digital'
		}
		transport.signal_kind.analog {
			return 'Analog'
		}
		transport.signal_kind.calculation {
			return 'Calculation'
		}
		transport.signal_kind.statistic {
			return 'Statistic'
		}
		transport.signal_kind.alarm {
			return 'Alarm'
		}
		transport.signal_kind.quality {
			return 'Quality'
		}
		transport.signal_kind.unknown {
			return 'Unknown'
		}
		else {
			return '0x' + strconv.format_int(i64(ske), 16)
		}
	}
}

// Acronym gets the SignalKind enumeration value as its two-character acronym str
pub fn (mut ske SignalKindEnum) acronym() string {
	match ske {
		transport.signal_kind.angle {
			return 'PA'
		}
		transport.signal_kind.magnitude {
			return 'PM'
		}
		transport.signal_kind.frequency {
			return 'FQ'
		}
		transport.signal_kind.df_dt {
			return 'DF'
		}
		transport.signal_kind.status {
			return 'SF'
		}
		transport.signal_kind.digital {
			return 'DV'
		}
		transport.signal_kind.analog {
			return 'AV'
		}
		transport.signal_kind.calculation {
			return 'CV'
		}
		transport.signal_kind.statistic {
			return 'ST'
		}
		transport.signal_kind.alarm {
			return 'AL'
		}
		transport.signal_kind.quality {
			return 'QF'
		}
		else {
			return '??'
		}
	}
}

// SignalTypeAcronym gets the specific four-character signal type acronym for a Signal
pub fn (mut ske SignalKindEnum) signal_type_acronym(phasorType rune) string {
	match ske {
		transport.signal_kind.angle {
			if unicode.to_upper(phasorType) == `V` {
				return 'VPHA'
			}
			return 'IPHA'
		}
		transport.signal_kind.magnitude {
			if unicode.to_upper(phasorType) == `V` {
				return 'VPHM'
			}
			return 'IPHM'
		}
		transport.signal_kind.frequency {
			return 'FREQ'
		}
		transport.signal_kind.df_dt {
			return 'DFDT'
		}
		transport.signal_kind.status {
			return 'FLAG'
		}
		transport.signal_kind.digital {
			return 'DIGI'
		}
		transport.signal_kind.analog {
			return 'ALOG'
		}
		transport.signal_kind.calculation {
			return 'CALC'
		}
		transport.signal_kind.statistic {
			return 'STAT'
		}
		transport.signal_kind.alarm {
			return 'ALRM'
		}
		transport.signal_kind.quality {
			return 'QUAL'
		}
		else {}
	}
	return 'NULL'
}

// ParseSignalKindAcronym gets the SignalKind enumeration value for the specified two-character acro
pub fn parse_signal_kind_acronym(acronym_1 string) SignalKindEnum {
	acronym_1 = acronym_1.to_upper().trim_space()
	if acronym_1 == 'PA' {
		return transport.signal_kind.angle
	}
	if acronym_1 == 'PM' {
		return transport.signal_kind.magnitude
	}
	if acronym_1 == 'FQ' {
		return transport.signal_kind.frequency
	}
	if acronym_1 == 'DF' {
		return transport.signal_kind.df_dt
	}
	if acronym_1 == 'SF' {
		return transport.signal_kind.status
	}
	if acronym_1 == 'DV' {
		return transport.signal_kind.digital
	}
	if acronym_1 == 'AV' {
		return transport.signal_kind.analog
	}
	if acronym_1 == 'CV' {
		return transport.signal_kind.calculation
	}
	if acronym_1 == 'ST' {
		return transport.signal_kind.statistic
	}
	if acronym_1 == 'AL' {
		return transport.signal_kind.alarm
	}
	if acronym_1 == 'QF' {
		return transport.signal_kind.quality
	}
	return transport.signal_kind.unknown
}
