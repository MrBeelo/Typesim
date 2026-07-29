package main

import rl "vendor:raylib"
import rlo "raylib_odin"

FontSize :: enum { STATS, MAIN }

fonts: [FontSize]rl.Font
MAIN_FONT_SIZE :: 64
FONT_SPACING :: 1

load_fonts :: proc() {
	for size in FontSize do fonts[size] = load_font(i32(get_font_size(size)))
}

load_font :: proc(font_size: i32) -> rl.Font {
	data := #load("../res/Kyrou7Wide.ttf")
	return rl.LoadFontFromMemory(".ttf", &data[0], i32(len(data)), font_size, nil, 0)
}

get_font_size :: proc(font_size: FontSize) -> f32 {
	switch font_size {
	case .STATS: return 32
	case .MAIN: return 64
	}
	return 0
}

get_codepoint_width :: proc(font: rl.Font, char: rune) -> f32 {
	index := int(rl.GetGlyphIndex(font, char))
	if font.glyphs[index].advanceX > 0 {
		return f32(font.glyphs[index].advanceX)
	} else {
		return (font.recs[index].width + f32(font.glyphs[index].offsetX))
	}
}

draw_text_centered :: proc(font: rl.Font, text: string, center: rl.Vector2, rotation: f32, font_size: f32, font_spacing: f32, tint: rl.Color) {
	text_size := rlo.MeasureTextEx(font, text, font_size, font_spacing)
	rlo.DrawTextPro(font, text, center, text_size / 2, rotation, font_size, font_spacing, tint)
}

get_font_color :: proc() -> rl.Color {
	return rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))
}