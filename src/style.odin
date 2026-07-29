package main

import rl "vendor:raylib"

GuiStyleProp :: struct {
    controlId: rl.GuiControl,
    propertyId: int,
    propertyValue: int,
}

CYBER_STYLE_PROPS_COUNT :: 17

cyberStyleProps := [CYBER_STYLE_PROPS_COUNT]GuiStyleProp {
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

GuiLoadStyleCyber :: proc() {
	for i in 0..<CYBER_STYLE_PROPS_COUNT {
		rl.GuiSetStyle(cyberStyleProps[i].controlId, i32(cyberStyleProps[i].propertyId), i32(cyberStyleProps[i].propertyValue))
	}

	font_size := rl.GuiGetStyle(.DEFAULT, i32(rl.GuiDefaultProperty.TEXT_SIZE))
	font := load_font(font_size)
	fontWhiteRec := rl.Rectangle{510, 254, 1, 1}

	rl.GuiSetFont(font)
	rl.SetShapesTexture(font.texture, fontWhiteRec)
}