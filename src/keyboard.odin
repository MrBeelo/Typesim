package main

import rl "vendor:raylib"
import "core:unicode/utf8"
import "core:strings"

KEY_SIZE :: f32(32)
SPACE_SIZE_RATIO :: f32(7)
KEY_OFFSET :: 4

// Draws a single key at the given center.
// 'outer_color' is the border color of the key, which won't be shown if colored keys are disabled.
// 'try_highlight' won't do anything if the corresponding setting hasn't been enabled.
// 'size' paramter should only be changed for space.
draw_keyboard_key :: proc(text: cstring, center: rl.Vector2, outer_color: rl.Color, try_highlight := false, size := rl.Vector2{KEY_SIZE, KEY_SIZE}) {
	THICKNESS :: 2
	rec := rl.Rectangle{center.x - size.x / 2, center.y - size.y / 2, size.x, size.y}

	highlight := try_highlight && settings.highlight_target_key

	border_color := focused_border_color() if highlight else border_color()
	base_color := focused_base_color() if highlight else base_color()
	text_color := focused_text_color() if highlight else text_color()

	if highlight || settings.show_key_base_color do rl.DrawRectangleRec(rec, base_color)
	rl.DrawRectangleLinesEx(rec, THICKNESS, outer_color if settings.colored_key_borders else border_color)
	draw_text_centered(get_font(.STATS), text, center, 0, get_font_size(.STATS), text_spacing(), text_color)
}

// Gets the offset for each key row. This is done so that it looks like a
// real keyboard, as if this wasn't done, the keys would be on a grid.
get_row_offset :: proc(row_index: int) -> f32 {
	switch row_index {
	case 0: return 0
	case 1: return KEY_SIZE / 4
	case 2: return KEY_SIZE * 3 / 4
	}
	return 0
}

// Gets the key color, depending on the key's column.
get_key_color :: proc(char_keyboard_index: int) -> rl.Color {
	switch char_keyboard_index {
	case -7, -6, -5: return rl.RED
	case -4: return rl.ORANGE
	case -3: return rl.YELLOW
	case -2, -1: return rl.GREEN
	case 0, 1: return rl.SKYBLUE
	case 2: return rl.PURPLE
	case 3: return rl.VIOLET
	case 4, 5, 6: return rl.PINK
	}

	return text_color()
}

// Draws the keyboard. 'target_char' is needed to highlight the target key.
draw_keyboard :: proc(target_char: rune) {
	if !settings.show_keyboard do return
	
	center := window_size / 2 + {0, get_font_size(.MAIN) + KEY_SIZE * 3 / 2}
	rows := [?]string {
		"QWERTYUIOP[]",
		"ASDFGHJKL;'",
		"ZXCVBNM,./",
	}

	for row, row_index in rows {
		y_offset := (f32(row_index) - 1) * (KEY_SIZE + KEY_OFFSET)

		for char, char_index in row {
			char_keyboard_index := char_index - 5 // 0 -> Y, H, N

			x_offset := f32(char_keyboard_index) * (KEY_SIZE + KEY_OFFSET)
			x_offset += get_row_offset(row_index)
			if settings.split_keyboard do x_offset += KEY_SIZE / 2 * (1 if char_keyboard_index >= 0 else -1)
			
			pos := center + {x_offset, y_offset}
			
			str := utf8.runes_to_string([]rune{char}, context.temp_allocator)
			cstr := strings.clone_to_cstring(str, context.temp_allocator)

			color := get_key_color(char_keyboard_index)

			draw_keyboard_key(cstr, pos, color, target_char == char || target_char == char + 32)
		}
	}

	{
		pos := center + {0, (KEY_SIZE + KEY_OFFSET) * 2}
		size := rl.Vector2{KEY_SIZE * SPACE_SIZE_RATIO, KEY_SIZE}
		draw_keyboard_key("SPACE", pos, text_color(), target_char == ' ', size)
	}	
}