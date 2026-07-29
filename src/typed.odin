package main

import rl "vendor:raylib"

MAX_TYPED_CHARS :: 23
typed_chars: [MAX_TYPED_CHARS]struct{ typed: rune, target: rune }

// Appends the character the user typed to the typed_chars array,
// as well as the target character.
append_typed_char :: proc(typed: rune, target: rune) {
	last := len(typed_chars) - 1
	copy(typed_chars[:last], typed_chars[1:])
	typed_chars[last] = {typed, target}
}

// Draws the characters the user has typed.
// This is done per-character for color support.
draw_typed_chars :: proc(font_size := FontSize.MAIN) {	
	total_offset_x: f32
	#reverse for char in typed_chars {
		font := fonts[font_size]
		
		// If the rune is the null rune (UTF-8 codepoint: 0) then return.
		// This would be catastrophic if it wasn't done, as every frame that
		// the user doesn't press any keys, rl.GetCharPressed() returns the null rune.
		if char.target == rune(0) do continue

		// Color the character green if it was correctly typed, red otherwise.
		color := rl.GREEN if char.typed == char.target else rl.RED

		// Replace spaces with underscores for typed characters.
		// This is done to show the user if they typed the space correctly.
		drawn_char := char.target if char.target != ' ' else '_'

		// Gets the characters width.
		size_x := get_codepoint_width(font, drawn_char)

		pos_x := window_size.x / 2 - total_offset_x - size_x
		pos_y := window_size.y / 2 - get_font_size(font_size) / 2

		rl.DrawTextCodepoint(font, drawn_char, {pos_x, pos_y}, get_font_size(font_size), color)
		
		total_offset_x += size_x + FONT_SPACING
	}
}