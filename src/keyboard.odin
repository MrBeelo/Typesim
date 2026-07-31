package main

import rl "vendor:raylib"
import "core:unicode/utf8"
import "core:strings"

KEY_SIZE :: f32(32)
SPACE_SIZE_RATIO :: f32(7)
OFFSET :: 4

draw_keyboard_key :: proc(text: cstring, center: rl.Vector2, color: rl.Color, highlight := false, size := rl.Vector2{KEY_SIZE, KEY_SIZE}) {
	THICKNESS :: 2
	rec := rl.Rectangle{center.x - size.x / 2, center.y - size.y / 2, size.x, size.y}

	if highlight {
		highlight_color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.BASE_COLOR_NORMAL))))
		rl.DrawRectangleRec(rec, highlight_color)
	}
	
	rl.DrawRectangleLinesEx(rec, THICKNESS, color)
	draw_text_centered(fonts[.KEYBOARD], text, center, 0, get_font_size(.KEYBOARD), FONT_SPACING, get_font_color())
}

get_row_offset :: proc(row_index: int) -> f32 {
	switch row_index {
	case 0: return 0
	case 1: return KEY_SIZE / 4
	case 2: return KEY_SIZE * 3 / 4
	}
	return 0
}

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

	return get_font_color()
}

draw_keyboard :: proc(target_char: rune) {
	center := window_size / 2 + {0, get_font_size(.MAIN) + KEY_SIZE * 3 / 2}
	rows := [?]string {
		"QWERTYUIOP[]",
		"ASDFGHJKL;'",
		"ZXCVBNM,./",
	}

	for row, row_index in rows {
		y_offset := (f32(row_index) - 1) * (KEY_SIZE + OFFSET)

		for char, char_index in row {
			char_keyboard_index := char_index - 5 // 0 -> Y, H, N

			x_offset := f32(char_keyboard_index) * (KEY_SIZE + OFFSET)
			x_offset += get_row_offset(row_index)
			x_offset += KEY_SIZE / 2 * (1 if char_keyboard_index >= 0 else -1)
			
			pos := center + {x_offset, y_offset}
			
			str := utf8.runes_to_string([]rune{char}, context.temp_allocator)
			cstr := strings.clone_to_cstring(str, context.temp_allocator)

			color := get_key_color(char_keyboard_index)

			draw_keyboard_key(cstr, pos, color, target_char == char || target_char == char + 32)
		}
	}

	{
		pos := center + {0, (KEY_SIZE + OFFSET) * 2}
		size := rl.Vector2{KEY_SIZE * SPACE_SIZE_RATIO, KEY_SIZE}
		draw_keyboard_key("SPACE", pos, get_font_color(), target_char == ' ', size)
	}	
}