package main

import rl "vendor:raylib"

Font_Size :: enum { STYLE, STATS, MAIN }
Font_Style :: enum { AMBER, CHERRY, CYBER, ENEFETE, GENESIS, HEXAMANIA, JUNGLE, LAVANDA, TERMINAL }

fonts: [Font_Style][Font_Size]rl.Font

load_fonts :: proc() {
	for style in Font_Style {
		// Load normal fonts (sizes are static, determined by get_font_size)
		for size in Font_Size do fonts[style][size] = load_font(i32(get_font_size(size, style)), style)
	}
}

load_font :: proc(font_size: i32, font_style: Font_Style) -> rl.Font {
	extension: cstring = ".ttf" if font_style != .JUNGLE else ".otf"
	data := get_font_data(font_style)
	font := rl.LoadFontFromMemory(extension, &data[0], i32(len(data)), font_size, nil, 0)
	return font
}

get_font :: proc(font_size: Font_Size) -> rl.Font {
	return fonts[settings.current_style][font_size]
}

get_font_data :: proc(font_style: Font_Style) -> []u8 {
	switch font_style {
	case .AMBER: return #load("../res/hello-world.ttf")
	case .CHERRY: return #load("../res/Westington.ttf")
	case .CYBER: return #load("../res/Kyrou7Wide.ttf")
	case .ENEFETE: return #load("../res/GenericMobileSystemNuevo.ttf")
	case .GENESIS: return #load("../res/PixelOperator.ttf")
	case .HEXAMANIA: return #load("../res/Quicksand-SemiBold.ttf")
	case .JUNGLE: return #load("../res/PixelIntv.otf")
	case .LAVANDA: return #load("../res/Cartridge.ttf")
	case .TERMINAL: return #load("../res/Mecha.ttf")
	}
	
	return {}
}

get_font_size :: proc(font_size: Font_Size, font_style := settings.current_style) -> f32 {
	switch font_size {
	case .STYLE: return f32(get_gui_text_size(styles[font_style]))
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