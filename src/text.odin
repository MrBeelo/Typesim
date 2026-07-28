package main

import rl "vendor:raylib"

font: rl.Font
FONT_SIZE :: 64
FONT_SPACING :: 1

load_font :: proc() {
	data := #load("../res/Kyrou7Wide.ttf")
	font = rl.LoadFontFromMemory(".ttf", &data[0], i32(len(data)), FONT_SIZE, nil, 0)
}

get_codepoint_width :: proc(char: rune) -> f32 {
	index := int(rl.GetGlyphIndex(font, char))
	if font.glyphs[index].advanceX > 0 {
		return f32(font.glyphs[index].advanceX)
	} else {
		return (font.recs[index].width + f32(font.glyphs[index].offsetX))
	}
}