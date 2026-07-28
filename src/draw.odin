package main

import rl "vendor:raylib"
import rlo "raylib_odin"
import "core:math"

font: rl.Font
FONT_SIZE :: 64
FONT_SPACING :: 1

load_font :: proc() {
	data := #load("../res/Kyrou7Wide.ttf")
	font = rl.LoadFontFromMemory(".ttf", &data[0], i32(len(data)), FONT_SIZE, nil, 0)
}

draw_word_text :: proc() {
	OFFSET_X :: 3
	
	color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))

	text := get_word_string()
	text_size := rlo.MeasureTextEx(font, text, FONT_SIZE, FONT_SPACING)
	rlo.DrawTextPro(font, text[cursor_index:], window_size / 2 + {OFFSET_X, -text_size.y / 2}, 0, 0, FONT_SIZE, FONT_SPACING, color)
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

draw_cursor :: proc() {
	if math.mod_f64(rl.GetTime(), 1) > 0.5 do return
	
	SIZE :: rl.Vector2{2, 36}
	OFFSET_Y :: 5
	
	color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))
	rect := rl.Rectangle{window_size.x / 2 - SIZE.x / 2, window_size.y / 2 - SIZE.y / 2 + OFFSET_Y, SIZE.x, SIZE.y}
	rl.DrawRectangleRec(rect, color)
}

get_codepoint_width :: proc(char: rune) -> f32 {
	index := int(rl.GetGlyphIndex(font, char))
	if font.glyphs[index].advanceX > 0 {
		return f32(font.glyphs[index].advanceX)
	} else {
		return (font.recs[index].width + f32(font.glyphs[index].offsetX))
	}
}

clear_background :: proc() {
	property := i32(rl.GuiDefaultProperty.BACKGROUND_COLOR)
	style := u32(rl.GuiGetStyle(.DEFAULT, property))
	rl.ClearBackground(rl.GetColor(style))
}