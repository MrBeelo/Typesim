package main

import "core:strings"
import rlo "raylib_odin"

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
	text_size := rlo.MeasureTextEx(fonts[font_size], text, get_font_size(font_size), FONT_SPACING)
	rlo.DrawTextPro(fonts[font_size], text[cursor_index:], window_size / 2 + {OFFSET_X, -text_size.y / 2}, 0, 0, get_font_size(font_size), 
		FONT_SPACING, get_font_color())
}