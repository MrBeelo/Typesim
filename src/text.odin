package main

import rl "vendor:raylib"

FontSize :: enum { STATS, MAIN }
FontStyle :: enum { CHERRY, CYBER, HEXAMANIA, JUNGLE, TERMINAL }

fonts: [FontStyle][FontSize]rl.Font
style_fonts: [FontStyle]rl.Font

load_fonts :: proc() {
	for style in FontStyle {
		// Load normal fonts (sizes are static, determined by get_font_size)
		for size in FontSize do fonts[style][size] = load_font(i32(get_font_size(size)), style)

		// Load gui style fonts (sizes are variable, as they depend on the style)
		style_fonts[style] = load_font(get_gui_text_size(styles[style]), style)
	}
}

load_font :: proc(font_size: i32, font_style: FontStyle) -> rl.Font {
	data, extension := get_font_data(font_style)
	font := rl.LoadFontFromMemory(extension, &data[0], i32(len(data)), font_size, nil, 0)
	return font
}

get_font :: proc(font_size: FontSize) -> rl.Font {
	return fonts[settings.current_style][font_size]
}

get_font_data :: proc(font_style: FontStyle) -> ([]u8, cstring) {
	switch font_style {
	case .CHERRY: return #load("../res/Westington.ttf"), ".ttf"
	case .CYBER: return #load("../res/Kyrou7Wide.ttf"), ".ttf"
	case .HEXAMANIA: return #load("../res/Quicksand-SemiBold.ttf"), ".ttf"
	case .JUNGLE: return #load("../res/PixelIntv.otf"), ".otf"
	case .TERMINAL: return #load("../res/Mecha.ttf"), ".ttf"
	}
	
	return {}, ""
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

draw_text_centered :: proc(font: rl.Font, text: cstring, center: rl.Vector2, rotation: f32, font_size: f32, font_spacing: f32, tint: rl.Color) {
	text_size := rl.MeasureTextEx(font, text, font_size, font_spacing)
	rl.DrawTextPro(font, text, center, text_size / 2, rotation, font_size, font_spacing, tint)
}