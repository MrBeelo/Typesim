package main

import "core:math"
import rl "vendor:raylib"

cursor_index: int

draw_cursor :: proc() {
	if math.mod_f64(rl.GetTime(), 1) > 0.5 do return
	
	SIZE :: rl.Vector2{2, 36}
	OFFSET_Y :: 5
	
	rect := rl.Rectangle{window_size.x / 2 - SIZE.x / 2, window_size.y / 2 - SIZE.y / 2 + OFFSET_Y, SIZE.x, SIZE.y}
	rl.DrawRectangleRec(rect, text_color())
}

perform_backspace :: proc() {
	cursor_index -= 1
	pop_typed_char()
}

can_perform_backspace :: proc() -> bool {
	return cursor_index > 0 && typed_chars[len(typed_chars) - 1].target != ' '
}