package main

typed_chars: [30]struct{ typed: rune, target: rune }

append_typed_char :: proc(typed: rune, target: rune) {
	for i in 0..<len(typed_chars) {
		typed_chars[i] = {typed, target} if i >= len(typed_chars) - 1 else typed_chars[i + 1]
	}
}