module ticks
import time
const (
min=Ticks(0 )
max=Ticks(3155378975999999999 )
per_second=Ticks(10000000 )
per_millisecond=Ticks(per_second  /  1000  )
per_microsecond=Ticks(per_second  /  1000000  )
per_minute=Ticks(60  *  per_second  )
per_hour=Ticks(60  *  per_minute  )
per_day=Ticks(24  *  per_hour  )
leap_second_flag=Ticks(1  <<  63  )
leap_second_direction=Ticks(1  <<  62  )
value_mask=Ticks(^ leap_second_flag   &  ^ leap_second_direction   )
unix_base_offset=Ticks(621355968000000000 )
time_format=string("2006-01-02 15:04:05.999999999" )
short_time_format=string("15:04:05.999" )
)
type Ticks = u64
// TimestampValue gets the timestamp portion of the Ticks value, i
pub fn (mut ticks Ticks) timestamp_value() (i64, ) {return i64(ticks  &  value_mask  ,) 
}

// ToTime converts a Ticks value to standard Go Time va
pub fn to_time(ticks Ticks) (time.Time, ) {return time.unix.utc() 
}

// FromTime converts a standard Go Time value to a Ticks va
pub fn from_time(time time.Time) (Ticks, ) {return (Ticks(time.unix_nano()  /  100  ,)  +  unix_base_offset  )  &  value_mask  
}

// IsLeapSecond determines if the deserialized Ticks value represents a leap second, i.e., second
pub fn is_leap_second(ticks_1 Ticks) (bool, ) {return (ticks_1  &  leap_second_flag  )  >  0  
}

// SetLeapSecond returns a copy of this Ticks value flagged to represent a leap second, i.e., second 60, before wire serializat
pub fn set_leap_second(ticks_2 Ticks) (Ticks, ) {return ticks_2  |  leap_second_flag  
}

// ApplyLeapSecond updates this Ticks value to represent a leap second, i.e., second 60, before wire serializat
pub fn (mut t Ticks) apply_leap_second() {t|=leap_second_flag  
}

// IsNegativeLeapSecond determines if the deserialized Ticks value represents a negative leap second, i.e., checks flag on second 58 to see if second 59 will be miss
pub fn is_negative_leap_second(ticks_3 Ticks) (bool, ) {return is_leap_second(ticks_3 ,)  &&  (ticks_3  &  leap_second_direction  )  >  0   
}

// SetNegativeLeapSecond returns a copy of this Ticks value flagged to represent a negative leap second, i.e., sets flag on second 58 to mark that second 59 will be missing, before wire serializat
pub fn set_negative_leap_second(ticks_4 Ticks) (Ticks, ) {return ticks_4  |  leap_second_flag   |  leap_second_direction  
}

// ApplyNegativeLeapSecond updates this Ticks value to represent a negative leap second, i.e., sets flag on second 58 to mark that second 59 will be missing, before wire serializat
pub fn (mut t Ticks) apply_negative_leap_second() {t|=leap_second_flag  |  leap_second_direction   
}

// Now gets the current local time as a Ticks va
pub fn now() (Ticks, ) {return from_time(time.now() ,) 
}

// UtcNow gets the current time in UTC as a Ticks va
pub fn utc_now() (Ticks, ) {return from_time(time.now.utc() ,) 
}

// ToTime converts a Ticks value to standard Go Time va
pub fn (mut t Ticks) to_time_1() (time.Time, ) {return to_time(t ,) 
}

// IsLeapSecond determines if the deserialized Ticks value represents a leap second, i.e., second
pub fn (mut t Ticks) is_leap_second_1() (bool, ) {return is_leap_second(t ,) 
}

// SetLeapSecond flags a Ticks value to represent a leap second, i.e., second 60, before wire serializat
pub fn (mut t Ticks) set_leap_second_1() (Ticks, ) {return set_leap_second(t ,) 
}

// String returns the string form of a Ticks value, i.e., a standard date/time value. See TimeFor
pub fn (mut t Ticks) string() (string, ) {return t.to_time.format(time_format ,) 
}

// ShortTime returns the short time string form of a Ticks va
pub fn (mut t Ticks) short_time() (string, ) {return t.to_time.format(short_time_format ,) 
}
