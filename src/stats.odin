package main

import "core:fmt"

words_typed: int
characters_typed: int
correct_characters_typed: int

word_type_times: [2]f32
char_type_times: [2]f32

// Gets the current WPM. The current WPM is not really the same as WPM in typing
// sites, as this just takes into account the time it took to write the last word,
// and completely ignores all previous words. This means that it could vastly vary
// depending on the length of the word.
get_wpm :: proc() -> f32 {
	word_diff := word_type_times[1] - word_type_times[0]
	letter_diff := (char_type_times[1] - char_type_times[0]) * avg_word_length
	diff := (word_diff + letter_diff) / 2
	return 0 if diff <= 0 else 60 / diff
}

draw_stats :: proc(font_size := FontSize.STATS) {
	accuracy := f32(correct_characters_typed) / f32(characters_typed) * 100 if characters_typed != 0 else 100
	wpm := get_wpm()

	texts := [?]cstring{
		fmt.ctprintf("WORDS TYPED: %d - ACCURACY: %.1f%%", words_typed, accuracy),
		fmt.ctprintf("CURRENT WPM: %.1f", wpm),
	}
	
	draw_text_centered(fonts[font_size], texts[0], window_size / 2 + {0, -(get_font_size(.MAIN) + get_font_size(.STATS) + 5)}, 
		0, get_font_size(font_size), FONT_SPACING, get_font_color())

	draw_text_centered(fonts[font_size], texts[1], window_size / 2 + {0, -get_font_size(.MAIN)}, 
		0, get_font_size(font_size), FONT_SPACING, get_font_color())
}