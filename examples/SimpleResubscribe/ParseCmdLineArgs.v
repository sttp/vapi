module main

import io
import math
import os
import strconv

fn parse_cmd_line_args() string {
	mut args := os.args
	if args.len < 3 {
		println('Usage:')
		println('    SimpleSubscribe HOSTNAME PORT')
		exit(1)
	}
	mut hostname := args[1]
	mut port, err := strconv.atoi(args[2])
	if err != unsafe { nil } {
		strconv.v_printf('Invalid port number "%s": %s\n', args[1], err.error())
		exit(2)
	}
	if port < 1 || port > math.max_uint16 {
		strconv.v_printf('Port number "%s" is out of range: must be 1 to %d\n', args[1],
			math.max_uint16)
		exit(2)
	}
	return hostname + ':' + strconv.itoa(port)
}

fn read_key() rune {
	mut r, _, _ := bufio.new_reader.read_rune()
	return r
}
