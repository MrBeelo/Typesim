package main

import rl "vendor:raylib"

Font_Size :: enum { STYLE, STATS, MAIN }
Font_Style :: enum { AMBER, CHERRY, CYBER, DEFAULT, ENEFETE, GENESIS, HEXAMANIA, JUNGLE, LAVANDA, TERMINAL }

fonts: [Font_Style][Font_Size]rl.Font

// Loads 3 of each font. 'STYLE' is based on the style tested.
load_fonts :: proc() {
	for style in Font_Style do for size in Font_Size {
		fonts[style][size] = load_font(i32(get_font_size(size, style)), style)
	}
}

// Gets the font that uses the current style.
get_font :: proc(font_size: Font_Size) -> rl.Font {
	return fonts[settings.current_style][font_size]
}

// Loads the font, based on the data embedded into the program.
load_font :: proc(font_size: i32, font_style: Font_Style) -> rl.Font {
	if font_style == .DEFAULT do return rl.GetFontDefault()
	extension: cstring = ".ttf" if font_style != .JUNGLE else ".otf" // Only the jungle font has an .otf extension.
	data := get_font_data(font_style)
	font := rl.LoadFontFromMemory(extension, &data[0], i32(len(data)), font_size, nil, 0)
	return font
}

// Gets the font data embedded into the program, to be loaded into memory.
get_font_data :: proc(font_style: Font_Style) -> []u8 {
	#partial switch font_style {
	case .AMBER: return #load("../res/font/hello-world.ttf")
	case .CHERRY: return #load("../res/font/Westington.ttf")
	case .CYBER: return #load("../res/font/Kyrou7Wide.ttf")
	case .ENEFETE: return #load("../res/font/GenericMobileSystemNuevo.ttf")
	case .GENESIS: return #load("../res/font/PixelOperator.ttf")
	case .HEXAMANIA: return #load("../res/font/Quicksand-SemiBold.ttf")
	case .JUNGLE: return #load("../res/font/PixelIntv.otf")
	case .LAVANDA: return #load("../res/font/Cartridge.ttf")
	case .TERMINAL: return #load("../res/font/Mecha.ttf")
	}
	
	return {}
}

// Given a Font_Size, returns its corresponding size as a float.
get_font_size :: proc(font_size: Font_Size, font_style := settings.current_style) -> f32 {
	switch font_size {
	case .STYLE: return f32(get_gui_text_size(styles[font_style]))
	case .STATS: return 32
	case .MAIN: return 64
	}
	
	return 0
}

// Self explanatory, copied from raylib's code :D
get_codepoint_width :: proc(font: rl.Font, char: rune, target_size := f32(0)) -> f32 {
	if font == rl.GetFontDefault() do return get_default_codepoint_width(char, target_size)
	index := int(rl.GetGlyphIndex(font, char))	
	if font.glyphs[index].advanceX > 0 {
		return f32(font.glyphs[index].advanceX)
	} else {
		return (font.recs[index].width + f32(font.glyphs[index].offsetX))
	}
}

get_default_codepoint_width :: proc(char: rune, font_size: f32) -> f32 {
	index := int(rl.GetGlyphIndex(rl.GetFontDefault(), char))	
	return (rl.GetFontDefault().recs[index].width * font_size) / 10
}

// More of a helper function, draws text using a center position instead of a top-left position.
draw_text_centered :: proc(font: rl.Font, text: cstring, center: rl.Vector2, rotation: f32, font_size: f32, font_spacing: f32, tint: rl.Color) {
	text_size := rl.MeasureTextEx(font, text, font_size, font_spacing)
	rl.DrawTextPro(font, text, center, text_size / 2, rotation, font_size, font_spacing, tint)
}