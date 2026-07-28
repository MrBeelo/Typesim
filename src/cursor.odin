package main

import "core:math"
import rl "vendor:raylib"

cursor_index: int

draw_cursor :: proc() {
	if math.mod_f64(rl.GetTime(), 1) > 0.5 do return
	
	SIZE :: rl.Vector2{2, 36}
	OFFSET_Y :: 5
	
	color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))
	rect := rl.Rectangle{window_size.x / 2 - SIZE.x / 2, window_size.y / 2 - SIZE.y / 2 + OFFSET_Y, SIZE.x, SIZE.y}
	rl.DrawRectangleRec(rect, color)
}