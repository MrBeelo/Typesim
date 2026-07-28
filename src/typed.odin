package main

import rl "vendor:raylib"

typed_chars: [30]struct{ typed: rune, target: rune }

append_typed_char :: proc(typed: rune, target: rune) {
	for i in 0..<len(typed_chars) {
		typed_chars[i] = {typed, target} if i >= len(typed_chars) - 1 else typed_chars[i + 1]
	}
}

draw_typed_chars :: proc() {
	total_offset_x: f32
	#reverse for char in typed_chars {
		if char.target == rune(0) do continue
		color := rl.GREEN if char.typed == char.target else rl.RED

		drawn_char := char.target if char.target != ' ' else '_'
		size_x := get_codepoint_width(drawn_char)

		pos_x := window_size.x / 2 - total_offset_x - size_x
		pos_y := window_size.y / 2 - FONT_SIZE / 2

		rl.DrawTextCodepoint(font, drawn_char, {pos_x, pos_y}, FONT_SIZE, color)
		
		total_offset_x += size_x + FONT_SPACING
	}
}