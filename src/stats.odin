package main

import "core:fmt"

words_typed: int
characters_typed: int
correct_characters_typed: int

draw_stats :: proc(font_size := FontSize.STATS) {
	accuracy := f32(correct_characters_typed) / f32(characters_typed) * 100 if characters_typed != 0 else 100
	text := string(fmt.ctprintf("WORDS TYPED: %d - ACCURACY: %.1f%%", words_typed, accuracy))
	draw_text_centered(fonts[font_size], text, window_size / 2 + {0, -get_font_size(.MAIN)}, 
		0, get_font_size(font_size), FONT_SPACING, get_font_color())
}