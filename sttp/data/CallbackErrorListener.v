module data
import github.com.antlr.antlr4.runtime.Go.antlr
struct CallbackErrorListener {&antlr.DefaultErrorListener

mut:
parsing_exception_callback fn ( string)  
}
// NewCallbackErrorListener creates a new NewCallbackErrorListe
pub fn new_callback_error_listener() (&CallbackErrorListener, ) {return & CallbackErrorListener{
default_error_listener:antlr.new_default_error_listener()  }  
}

// SyntaxError is called when ANTLR parser encounters a syntax er
pub fn (mut cel CallbackErrorListener) syntax_error<T>(recognizer antlr.Recognizer, offendingSymbol T, line int, msg string, e antlr.RecognitionException) {if cel.parsing_exception_callback  ==  unsafe { nil }  {
return 
}
cel.parsing_exception_callback(msg ,)
}
