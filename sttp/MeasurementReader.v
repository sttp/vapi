module sttp
import context
import goapi.
struct MeasurementReader {
mut:
current  
}
fn new_measurement_reader(parent &Subscriber) (&MeasurementReader, ) {mut reader:=& MeasurementReader{
current:NOT_YET_IMPLEMENTED {}  }   
parent.set_new_measurements_receiver(fn (measurements []transport.Measurement) {for i, _ in  measurements  {
NOT_YET_IMPLEMENTED
}
}
 ,)
return reader 
}

// NextMeasurement blocks current thread until a new measurement arrives or provided context is comple
pub fn (mut mr MeasurementReader) next_measurement(ctx context.Context) (&transport.Measurement, bool, ) {if ctx  ==  unsafe { nil }  {
ctx=context.background()  
}
NOT_YET_IMPLEMENTED
}

// Close closes the measurement reader chan
pub fn (mut mr MeasurementReader) close() {close(mr.current ,)
}
