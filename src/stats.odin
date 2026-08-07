package main

import rl "vendor:raylib"
import "core:math"
import "core:fmt"

words_typed: int
characters_typed: int
correct_characters_typed: int

word_type_times: [2]f32
char_type_times: [2]f32

time_spent: f32

// Self explanatory :D
draw_stats :: proc() {
	font_size := Font_Size.STATS
	accuracy := f32(correct_characters_typed) / f32(characters_typed) * 100 if characters_typed != 0 else 100
	wpm := get_wpm()

	texts := [?]cstring{
		fmt.ctprintf("TIME SPENT: %s - WORDS TYPED: %d", time_string(time_spent), words_typed),
		fmt.ctprintf("CURRENT WPM: %.1f - ACCURACY: %.1f%%", wpm, accuracy),
	}

	for text, index in texts {
		y_offset := get_font_size(.MAIN) + (get_font_size(.STATS) + 5) * (len(texts) - f32(index) - 1)
		draw_text_centered(get_font(font_size), text, window_size / 2 - {0, y_offset}, 
			0, get_font_size(font_size), text_spacing(.STATS), text_color())
	}
}

// Gets the CURRENT words per minute, depending on the setting.
// Being current, it isn't influenced by the user's past performace.
get_wpm :: proc() -> f32 {
	word_diff := word_type_times[1] - word_type_times[0]
	letter_diff := (char_type_times[1] - char_type_times[0]) * avg_word_length
	avg_diff := (word_diff + letter_diff) / 2

	diff: f32
	switch settings.wpm_format {
	case .CHAR_ONLY: diff = letter_diff
	case .WORD_ONLY: diff = word_diff
	case .CHAR_WORD_AVG: diff = avg_diff
	}
	
	return 0 if diff <= 0 else 60 / diff
}

// More of a helper function, takes a float and returns a 'timer' string.
time_string :: proc(value: f32) -> string {
	mins := int(math.floor(value / 60))
	secs := int(math.floor(value)) % 60
	mins = math.max(mins, 0)
	secs = math.max(secs, 0)
	str := string(rl.TextFormat("%2d:%02d", mins, secs))
	return str
}