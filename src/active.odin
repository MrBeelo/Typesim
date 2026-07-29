package main

import "core:strings"
import rl "vendor:raylib"
import rlo "raylib_odin"

MAX_ACTIVE_WORDS :: 7
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
}

// Draws the words incoming (active words).
draw_word_text :: proc(font_size := FontSize.MAIN) {
	OFFSET_X :: 3

	font := fonts[font_size]
	
	color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))

	text := get_word_string()
	text_size := rlo.MeasureTextEx(font, text, get_font_size(font_size), FONT_SPACING)
	rlo.DrawTextPro(font, text[cursor_index:], window_size / 2 + {OFFSET_X, -text_size.y / 2}, 0, 0, get_font_size(font_size), FONT_SPACING, color)
}