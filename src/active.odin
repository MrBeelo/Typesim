package main

import "core:strings"

active_words: [10]string
cursor_index: int

// Gets a string of all active words.
get_word_string :: proc() -> string {
	return strings.concatenate(active_words[:], context.temp_allocator)
}

advance_word :: proc() {
	for i in 0..<len(active_words) {
		active_words[i] = get_random_word() if i >= len(active_words) - 1 else active_words[i + 1]
	}
}