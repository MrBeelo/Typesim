package main

import "core:strings"
import rl "vendor:raylib"

MAX_ACTIVE_WORDS :: 15
active_words: [MAX_ACTIVE_WORDS]string

// Gets a string of all active words.
get_word_string :: proc() -> string {
	return strings.concatenate(active_words[:], context.temp_allocator)
}

// Adds another word to the active word array.
advance_word :: proc() {
	last := len(active_words) - 1
	copy(active_words[:last], active_words[1:])
	active_words[last] = get_random_word()
	words_typed += 1
}

// Draws the words incoming (active words).
draw_word_text :: proc(font_size := FontSize.MAIN) {
	OFFSET_X :: 3
	
	text := get_word_string()
	total_offset_x: f32
	
	for char in text[cursor_index:] {
		// Just for safety!
		if char == rune(0) do continue

		// Gets the characters width.
		size_x := get_codepoint_width(fonts[font_size], char)

		pos: rl.Vector2
		pos.x = window_size.x / 2 + total_offset_x + OFFSET_X
		pos.y = window_size.y / 2 - get_font_size(font_size) / 2

		rl.DrawTextCodepoint(fonts[font_size], char, pos, get_font_size(font_size), get_font_color())
		
		total_offset_x += size_x + FONT_SPACING
	}
}