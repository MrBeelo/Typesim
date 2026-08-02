package main

import rl "vendor:raylib"
import "core:math"
import "core:fmt"

words_typed: int
characters_typed: int
correct_characters_typed: int

word_type_times: [2]f32
char_type_times: [2]f32

draw_stats :: proc(font_size := FontSize.STATS) {
	accuracy := f32(correct_characters_typed) / f32(characters_typed) * 100 if characters_typed != 0 else 100
	wpm := get_wpm()

	texts := [?]cstring{
		fmt.ctprintf("TIME SPENT: %s", time_string(f32(rl.GetTime()))),
		fmt.ctprintf("WORDS TYPED: %d - ACCURACY: %.1f%%", words_typed, accuracy),
		fmt.ctprintf("CURRENT WPM: %.1f", wpm),
	}

	for text, index in texts {
		y_offset := get_font_size(.MAIN) + (get_font_size(.STATS) + 5) * (len(texts) - f32(index) - 1)
		draw_text_centered(get_font(font_size), text, window_size / 2 - {0, y_offset}, 
			0, get_font_size(font_size), text_spacing(), text_color())
	}
}

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

time_string :: proc(value: f32) -> string {
	mins := int(math.floor(value / 60))
	secs := int(math.floor(value)) % 60
	mins = math.max(mins, 0)
	secs = math.max(secs, 0)
	str := string(rl.TextFormat("%2d:%02d", mins, secs))
	return str
}