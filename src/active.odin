package main

import "core:strings"
import rl "vendor:raylib"
import rlo "raylib_odin"

active_words: [10]string


// Gets a string of all active words.
get_word_string :: proc() -> string {
	return strings.concatenate(active_words[:], context.temp_allocator)
}

advance_word :: proc() {
	for i in 0..<len(active_words) {
		active_words[i] = get_random_word() if i >= len(active_words) - 1 else active_words[i + 1]
	}
}

draw_word_text :: proc() {
	OFFSET_X :: 3
	
	color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))

	text := get_word_string()
	text_size := rlo.MeasureTextEx(font, text, FONT_SIZE, FONT_SPACING)
	rlo.DrawTextPro(font, text[cursor_index:], window_size / 2 + {OFFSET_X, -text_size.y / 2}, 0, 0, FONT_SIZE, FONT_SPACING, color)
}