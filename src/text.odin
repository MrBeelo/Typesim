package main

import rl "vendor:raylib"

FontSize :: enum { KEYBOARD, STATS, MAIN }
FontStyle :: enum { CYBER, HEXAMANIA }

fonts: [FontStyle][FontSize]rl.Font
FONT_SPACING :: 1

load_fonts :: proc() {
	for size in FontSize do for style in FontStyle do fonts[style][size] = load_font(i32(get_font_size(size)), style)
}

load_font :: proc(font_size: i32, font_style: FontStyle) -> rl.Font {
	data := get_font_data(font_style)
	font := rl.LoadFontFromMemory(".ttf", &data[0], i32(len(data)), font_size, nil, 0)
	rl.SetTextureFilter(font.texture, .BILINEAR)
	return font
}

get_font :: proc(font_size: FontSize) -> rl.Font {
	return fonts[current_style][font_size]
}

get_font_data :: proc(font_style: FontStyle) -> []u8 {
	switch font_style {
	case .CYBER: return #load("../res/Kyrou7Wide.ttf")
	case .HEXAMANIA: return #load("../res/Quicksand-SemiBold.ttf")
	}
	
	return {}
}

get_font_size :: proc(font_size: FontSize) -> f32 {
	switch font_size {
	case .KEYBOARD: return 24
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

draw_text_centered :: proc(font: rl.Font, text: cstring, center: rl.Vector2, rotation: f32, font_size: f32, font_spacing: f32, tint: rl.Color) {
	text_size := rl.MeasureTextEx(font, text, font_size, font_spacing)
	rl.DrawTextPro(font, text, center, text_size / 2, rotation, font_size, font_spacing, tint)
}