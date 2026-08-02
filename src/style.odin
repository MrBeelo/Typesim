package main

import rl "vendor:raylib"

GuiStyleProp :: struct {
    controlId: rl.GuiControl,
    propertyId: int,
    propertyValue: i64,
}

activate_style :: proc(style: FontStyle) {
	props := styles[style]
	for i in 0..<len(props) {
		rl.GuiSetStyle(props[i].controlId, i32(props[i].propertyId), i32(props[i].propertyValue))
	}

	font := style_fonts[style]

	rl.GuiSetFont(font)
	rl.SetShapesTexture(font.texture, {510, 254, 1, 1})

	settings.current_style = style
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

text_spacing :: proc() -> f32 { return f32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiDefaultProperty.TEXT_SPACING))) }

get_gui_text_size :: proc(props: []GuiStyleProp) -> i32 {
	for prop in props do if prop.propertyId == int(rl.GuiDefaultProperty.TEXT_SIZE) do return i32(prop.propertyValue)
	return 0
}

styles := [FontStyle][]GuiStyleProp {
	.CHERRY = {
		{ .DEFAULT, 0, 0xda5757ff },    // DEFAULT_BORDER_COLOR_NORMAL
    	{ .DEFAULT, 1, 0x753233ff },    // DEFAULT_BASE_COLOR_NORMAL
     	{ .DEFAULT, 2, 0xe17373ff },    // DEFAULT_TEXT_COLOR_NORMAL
     	{ .DEFAULT, 3, 0xfaaa97ff },    // DEFAULT_BORDER_COLOR_FOCUSED
     	{ .DEFAULT, 4, 0xe06262ff },    // DEFAULT_BASE_COLOR_FOCUSED
      	{ .DEFAULT, 5, 0xfdb4aaff },    // DEFAULT_TEXT_COLOR_FOCUSED
       	{ .DEFAULT, 6, 0xe03c46ff },    // DEFAULT_BORDER_COLOR_PRESSED
        { .DEFAULT, 7, 0x5b1e20ff },    // DEFAULT_BASE_COLOR_PRESSED
        { .DEFAULT, 8, 0xc2474fff },    // DEFAULT_TEXT_COLOR_PRESSED
        { .DEFAULT, 9, 0xa19292ff },    // DEFAULT_BORDER_COLOR_DISABLED
        { .DEFAULT, 10, 0x706060ff },    // DEFAULT_BASE_COLOR_DISABLED
        { .DEFAULT, 11, 0x9e8585ff },    // DEFAULT_TEXT_COLOR_DISABLED
        { .DEFAULT, 16, 0x0000000f },    // DEFAULT_TEXT_SIZE 
        { .DEFAULT, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
        { .DEFAULT, 18, 0xfb8170ff },    // DEFAULT_LINE_COLOR 
        { .DEFAULT, 19, 0x3a1720ff },    // DEFAULT_BACKGROUND_COLOR 
        { .DEFAULT, 20, 0x00000007 },    // DEFAULT_TEXT_LINE_SPACING 
	},
	.CYBER = {
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
	},
	.HEXAMANIA = {
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
	},
	.JUNGLE = {
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
	},
	.TERMINAL = {
    	{ .DEFAULT, 0, 0x1c8d00ff },    // DEFAULT_BORDER_COLOR_NORMAL
     	{ .DEFAULT, 1, 0x161313ff },    // DEFAULT_BASE_COLOR_NORMAL
     	{ .DEFAULT, 2, 0x38f620ff },    // DEFAULT_TEXT_COLOR_NORMAL
      	{ .DEFAULT, 3, 0xc3fbc6ff },    // DEFAULT_BORDER_COLOR_FOCUSED
       	{ .DEFAULT, 4, 0x43bf2eff },    // DEFAULT_BASE_COLOR_FOCUSED
        { .DEFAULT, 5, 0xdcfadcff },    // DEFAULT_TEXT_COLOR_FOCUSED
        { .DEFAULT, 6, 0x1f5b19ff },    // DEFAULT_BORDER_COLOR_PRESSED
        { .DEFAULT, 7, 0x43ff28ff },    // DEFAULT_BASE_COLOR_PRESSED
        { .DEFAULT, 8, 0x1e6f15ff },    // DEFAULT_TEXT_COLOR_PRESSED
        { .DEFAULT, 9, 0x223b22ff },    // DEFAULT_BORDER_COLOR_DISABLED
        { .DEFAULT, 10, 0x182c18ff },    // DEFAULT_BASE_COLOR_DISABLED
        { .DEFAULT, 11, 0x244125ff },    // DEFAULT_TEXT_COLOR_DISABLED
        { .DEFAULT, 16, 0x00000010 },    // DEFAULT_TEXT_SIZE 
        { .DEFAULT, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
        { .DEFAULT, 18, 0xe6fce3ff },    // DEFAULT_LINE_COLOR 
        { .DEFAULT, 19, 0x0c1505ff },    // DEFAULT_BACKGROUND_COLOR 
        { .DEFAULT, 20, 0x00000008 },    // DEFAULT_TEXT_LINE_SPACING 
	},
}