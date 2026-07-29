package main

import rl "vendor:raylib"

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