module thread

import sync
import github.com.tevino.abool.v2

struct Thread {
mut:
	exec    fn ()
	mutex   sync.Mutex
	running abool.AtomicBool
}

// NewThread creates a new Thr
pub fn new_thread(exec fn ()) &Thread {
	return &Thread{
		exec: exec
	}
}

// Start causes the thread function to be scheduled for execution via a new Go rout
pub fn (mut thread Thread) start() {
	if thread.exec == unsafe { nil } {
		panic('thread has no execution function defined')
	}
	if thread.running.is_set() {
		panic('thread is already running')
	}
	thread.mutex.@lock()
	spawn thread.run()
}

// TryStart attempts to cause the thread function to be scheduled for execution via a new Go rout
pub fn (mut thread Thread) try_start() bool {
	defer {
		recover()
	}
	if thread.exec != unsafe { nil } && thread.running.is_not_set() {
		thread.start()
		return true
	}
	return false
}

// Join blocks the calling thread until this Thread termina
pub fn (mut thread Thread) join() {
	if thread.exec == unsafe { nil } || thread.running.is_not_set() {
		return
	}
	thread.mutex.@lock()
	thread.mutex.unlock()
}

// IsRunning safely determines if the thread function is currently execut
pub fn (mut thread Thread) is_running() bool {
	return thread.running.is_set()
}

fn (mut thread Thread) run() {
	defer {
		thread.running.un_set()
	}
	defer {
		thread.mutex.unlock()
	}
	thread.running.set()
	thread.exec()
}
