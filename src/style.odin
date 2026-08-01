package main

import rl "vendor:raylib"

GuiStyleProp :: struct {
    controlId: rl.GuiControl,
    propertyId: int,
    propertyValue: i64,
}

activate_style :: proc(style: FontStyle) {
	switch style {
	case .CYBER: activate_style_ex(len(cyber_style), cyber_style, .CYBER)
	case .JUNGLE: activate_style_ex(len(jungle_style), jungle_style, .JUNGLE)
	case .HEXAMANIA: activate_style_ex(len(hexamania_style), hexamania_style, .HEXAMANIA)
	}
}

activate_style_ex :: proc($prop_count: int, props: [prop_count]GuiStyleProp, style: FontStyle) {
	for i in 0..<prop_count {
		rl.GuiSetStyle(props[i].controlId, i32(props[i].propertyId), i32(props[i].propertyValue))
	}

	font_size := rl.GuiGetStyle(.DEFAULT, i32(rl.GuiDefaultProperty.TEXT_SIZE))
	font := load_font(font_size, style)

	rl.GuiSetFont(font)
	rl.SetShapesTexture(font.texture, get_font_white_rec(style))
}

get_font_white_rec :: proc(style: FontStyle) -> rl.Rectangle {
	switch style {
	case .CYBER: return {510, 254, 1, 1}
	case .JUNGLE: return {254, 254, 1, 1}
	case .HEXAMANIA: return {510, 254, 1, 1}
	}

	return {}
}

get_property_color :: proc(property: i32) -> rl.Color {
	return rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, property)))
}

border_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BORDER_COLOR_NORMAL)) }
base_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BASE_COLOR_NORMAL)) }
text_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL)) }

focused_border_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BORDER_COLOR_FOCUSED)) }
focused_base_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BASE_COLOR_FOCUSED)) }
focused_text_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.TEXT_COLOR_FOCUSED)) }

background_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiDefaultProperty.BACKGROUND_COLOR)) }

cyber_style := [?]GuiStyleProp {
	{ .DEFAULT, 0, 0x2f7486ff },    // DEFAULT_BORDER_COLOR_NORMAL
    { .DEFAULT, 1, 0x024658ff },    // DEFAULT_BASE_COLOR_NORMAL
    { .DEFAULT, 2, 0x51bfd3ff },    // DEFAULT_TEXT_COLOR_NORMAL
    { .DEFAULT, 3, 0x82cde0ff },    // DEFAULT_BORDER_COLOR_FOCUSED
    { .DEFAULT, 4, 0x3299b4ff },    // DEFAULT_BASE_COLOR_FOCUSED
    { .DEFAULT, 5, 0xb6e1eaff },    // DEFAULT_TEXT_COLOR_FOCUSED
    { .DEFAULT, 6, 0xeb7630ff },    // DEFAULT_BORDER_COLOR_PRESSED
    { .DEFAULT, 7, 0xffbc51ff },    // DEFAULT_BASE_COLOR_PRESSED
    { .DEFAULT, 8, 0xd86f36ff },    // DEFAULT_TEXT_COLOR_PRESSED
    { .DEFAULT, 9, 0x134b5aff },    // DEFAULT_BORDER_COLOR_DISABLED
    { .DEFAULT, 10, 0x02313dff },    // DEFAULT_BASE_COLOR_DISABLED
    { .DEFAULT, 11, 0x17505fff },    // DEFAULT_TEXT_COLOR_DISABLED
    { .DEFAULT, 16, 0x0000000e },    // DEFAULT_TEXT_SIZE 
    { .DEFAULT, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
    { .DEFAULT, 18, 0x81c0d0ff },    // DEFAULT_LINE_COLOR 
    { .DEFAULT, 19, 0x00222bff },    // DEFAULT_BACKGROUND_COLOR 
    { .DEFAULT, 20, 0x00000007 },    // DEFAULT_TEXT_LINE_SPACING 
}

jungle_style := [?]GuiStyleProp {
    { .DEFAULT, 0, 0x60827dff },    // DEFAULT_BORDER_COLOR_NORMAL
    { .DEFAULT, 1, 0x2c3334ff },    // DEFAULT_BASE_COLOR_NORMAL
    { .DEFAULT, 2, 0x82a29fff },    // DEFAULT_TEXT_COLOR_NORMAL
    { .DEFAULT, 3, 0x5f9aa8ff },    // DEFAULT_BORDER_COLOR_FOCUSED
    { .DEFAULT, 4, 0x334e57ff },    // DEFAULT_BASE_COLOR_FOCUSED
    { .DEFAULT, 5, 0x6aa9b8ff },    // DEFAULT_TEXT_COLOR_FOCUSED
    { .DEFAULT, 6, 0xa9cb8dff },    // DEFAULT_BORDER_COLOR_PRESSED
    { .DEFAULT, 7, 0x3b6357ff },    // DEFAULT_BASE_COLOR_PRESSED
    { .DEFAULT, 8, 0x97af81ff },    // DEFAULT_TEXT_COLOR_PRESSED
    { .DEFAULT, 9, 0x5b6462ff },    // DEFAULT_BORDER_COLOR_DISABLED
    { .DEFAULT, 10, 0x2c3334ff },    // DEFAULT_BASE_COLOR_DISABLED
    { .DEFAULT, 11, 0x666b69ff },    // DEFAULT_TEXT_COLOR_DISABLED
    { .DEFAULT, 16, 0x0000000c },    // DEFAULT_TEXT_SIZE 
    { .DEFAULT, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
    { .DEFAULT, 18, 0x638465ff },    // DEFAULT_LINE_COLOR 
    { .DEFAULT, 19, 0x2b3a3aff },    // DEFAULT_BACKGROUND_COLOR 
    { .DEFAULT, 20, 0x00000006 },    // DEFAULT_TEXT_LINE_SPACING 
}

hexamania_style := [?]GuiStyleProp {
    { .DEFAULT, 0, 0x8449deff },    // DEFAULT_BORDER_COLOR_NORMAL 
    { .DEFAULT, 1, 0x1a0034ff },    // DEFAULT_BASE_COLOR_NORMAL 
    { .DEFAULT, 2, 0xffffffff },    // DEFAULT_TEXT_COLOR_NORMAL 
    { .DEFAULT, 3, 0x8449deff },    // DEFAULT_BORDER_COLOR_FOCUSED 
    { .DEFAULT, 4, 0x3b1576ff },    // DEFAULT_BASE_COLOR_FOCUSED 
    { .DEFAULT, 5, 0xffffffff },    // DEFAULT_TEXT_COLOR_FOCUSED 
    { .DEFAULT, 6, 0x8220caff },    // DEFAULT_BORDER_COLOR_PRESSED 
    { .DEFAULT, 7, 0x4b0f7eff },    // DEFAULT_BASE_COLOR_PRESSED 
    { .DEFAULT, 8, 0xffffffff },    // DEFAULT_TEXT_COLOR_PRESSED 
    { .DEFAULT, 9, 0x3c0e55ff },    // DEFAULT_BORDER_COLOR_DISABLED 
    { .DEFAULT, 10, 0x2a0a44ff },    // DEFAULT_BASE_COLOR_DISABLED 
    { .DEFAULT, 11, 0x8f8f8fff },    // DEFAULT_TEXT_COLOR_DISABLED 
    { .DEFAULT, 16, 0x00000010 },    // DEFAULT_TEXT_SIZE 
    { .DEFAULT, 18, 0x8449deff },    // DEFAULT_LINE_COLOR 
    { .DEFAULT, 19, 0x180038ff },    // DEFAULT_BACKGROUND_COLOR 
    { .DEFAULT, 20, 0x00000018 },    // DEFAULT_TEXT_LINE_SPACING 
}