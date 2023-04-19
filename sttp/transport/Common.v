module transport

import compress.gzip
import crypto.aes
import crypto.cipher
import io

fn decipher_aes(key []u8) ([]u8, error) {
	mut block := cipher.Block{}
	mut err := error{}
	block, err = aes.new_cipher(key)
	if err != unsafe { nil } {
		return unsafe { nil }, err
	}
	mut mode := cipher.new_cbcdecrypter(block, iv)
	mut out := []u8{len: data.len}
	mode.crypt_blocks(out, data)
	return out, unsafe { nil }
}

fn decompress_gzip(data []u8) ([]u8, error) {
	mut reader := &gzip.Reader{}
	mut err := error{}
	reader, err = gzip.new_reader(bytes.new_reader(data))
	if err != unsafe { nil } {
		return unsafe { nil }, err
	}
	defer {
		reader.close()
	}
	data, err = io.read_all(reader)
	if err != unsafe { nil } {
		return unsafe { nil }, err
	}
	return data, unsafe { nil }
}
