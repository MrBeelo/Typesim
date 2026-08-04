package main

import rl "vendor:raylib"

Gui_Style_Prop :: struct {
    control_id: rl.GuiControl,
    property_id: int,
    property_value: i64,
}

// Activates the given style. This used to load the style font,
// but this is now done once along with the other fonts at the start
// of the program, for better performance.
// This is basically equivalent to LoadGuiStyle<style>() that's generated
// by rGuiStyler, just without loading the font.
activate_style :: proc(style: Font_Style) {
	settings.current_style = style

	props := styles[style]
	for i in 0..<len(props) {
		rl.GuiSetStyle(props[i].control_id, i32(props[i].property_id), i32(props[i].property_value))
	}

	font := get_font(.STYLE)
	rl.GuiSetFont(font)
	rl.SetShapesTexture(font.texture, {510, 254, 1, 1})
}

// Given a property, returns its value, as a color.
get_property_color :: proc(property: i32) -> rl.Color {
	return rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, property)))
}

// PROPERTY FUNCTIONS
border_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BORDER_COLOR_NORMAL)) }
base_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BASE_COLOR_NORMAL)) }
text_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL)) }

focused_border_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BORDER_COLOR_FOCUSED)) }
focused_base_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.BASE_COLOR_FOCUSED)) }
focused_text_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiControlProperty.TEXT_COLOR_FOCUSED)) }

background_color :: proc() -> rl.Color { return get_property_color(i32(rl.GuiDefaultProperty.BACKGROUND_COLOR)) }

text_spacing :: proc() -> f32 { return f32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiDefaultProperty.TEXT_SPACING))) }

// This is like a property function, but because it has to be called before any properties
// have been activated, it takes some property slice.
get_gui_text_size :: proc(props: []Gui_Style_Prop) -> i32 {
	for prop in props do if prop.property_id == int(rl.GuiDefaultProperty.TEXT_SIZE) do return i32(prop.property_value)
	return 0
}

// A list of properties for each style. These can be found on the generated
// <style>.h files on raygui's github.
styles := [Font_Style][]Gui_Style_Prop {
	.AMBER = {
    	{ .DEFAULT, 0, 0x898988ff },    // DEFAULT_BORDER_COLOR_NORMAL
    	{ .DEFAULT, 1, 0x292929ff },    // DEFAULT_BASE_COLOR_NORMAL
    	{ .DEFAULT, 2, 0xd4d4d4ff },    // DEFAULT_TEXT_COLOR_NORMAL
    	{ .DEFAULT, 3, 0xeb891dff },    // DEFAULT_BORDER_COLOR_FOCUSED
    	{ .DEFAULT, 4, 0x292929ff },    // DEFAULT_BASE_COLOR_FOCUSED
    	{ .DEFAULT, 5, 0xffffffff },    // DEFAULT_TEXT_COLOR_FOCUSED
    	{ .DEFAULT, 6, 0xf1cf9dff },    // DEFAULT_BORDER_COLOR_PRESSED
    	{ .DEFAULT, 7, 0xf39333ff },    // DEFAULT_BASE_COLOR_PRESSED
    	{ .DEFAULT, 8, 0x191410ff },    // DEFAULT_TEXT_COLOR_PRESSED
    	{ .DEFAULT, 9, 0x6a6a6aff },    // DEFAULT_BORDER_COLOR_DISABLED
    	{ .DEFAULT, 10, 0x818181ff },    // DEFAULT_BASE_COLOR_DISABLED
    	{ .DEFAULT, 11, 0x606060ff },    // DEFAULT_TEXT_COLOR_DISABLED
    	{ .DEFAULT, 16, 0x00000010 },    // DEFAULT_TEXT_SIZE 
     	{ .DEFAULT, 17, 0x00000001 },    // DEFAULT_TEXT_SPACING 
    	{ .DEFAULT, 18, 0xef922aff },    // DEFAULT_LINE_COLOR 
    	{ .DEFAULT, 19, 0x333333ff },    // DEFAULT_BACKGROUND_COLOR 
    	{ .DEFAULT, 20, 0x00000008 },    // DEFAULT_TEXT_LINE_SPACING 
    	{ .LABEL, 8, 0xe7e0d4ff },       // LABEL_TEXT_COLOR_PRESSED
    	{ .SLIDER, 8, 0xf1cf9dff },      // SLIDER_TEXT_COLOR_PRESSED
	},
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
	.ENEFETE = {
    	{ .DEFAULT, 0, 0x1980d5ff },    // DEFAULT_BORDER_COLOR_NORMAL
    	{ .DEFAULT, 1, 0x4df3ebff },    // DEFAULT_BASE_COLOR_NORMAL
    	{ .DEFAULT, 2, 0x103e60ff },    // DEFAULT_TEXT_COLOR_NORMAL
    	{ .DEFAULT, 3, 0xe7e2f7ff },    // DEFAULT_BORDER_COLOR_FOCUSED
    	{ .DEFAULT, 4, 0x23d4ddff },    // DEFAULT_BASE_COLOR_FOCUSED
    	{ .DEFAULT, 5, 0xf1f1f1ff },    // DEFAULT_TEXT_COLOR_FOCUSED
    	{ .DEFAULT, 6, 0x6413a6ff },    // DEFAULT_BORDER_COLOR_PRESSED
    	{ .DEFAULT, 7, 0xea66d9ff },    // DEFAULT_BASE_COLOR_PRESSED
    	{ .DEFAULT, 8, 0x9f00bbff },    // DEFAULT_TEXT_COLOR_PRESSED
    	{ .DEFAULT, 9, 0x4b909eff },    // DEFAULT_BORDER_COLOR_DISABLED
    	{ .DEFAULT, 10, 0x73c7d0ff },    // DEFAULT_BASE_COLOR_DISABLED
    	{ .DEFAULT, 11, 0x448894ff },    // DEFAULT_TEXT_COLOR_DISABLED
    	{ .DEFAULT, 16, 0x00000010 },    // DEFAULT_TEXT_SIZE 
    	{ .DEFAULT, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
    	{ .DEFAULT, 18, 0x1d3f6cff },    // DEFAULT_LINE_COLOR 
    	{ .DEFAULT, 19, 0x29c9e5ff },    // DEFAULT_BACKGROUND_COLOR 
    	{ .DEFAULT, 20, 0x00000008 },    // DEFAULT_TEXT_LINE_SPACING 
	},
	.GENESIS = {
    	{ .DEFAULT, 0, 0x667384ff },    // DEFAULT_BORDER_COLOR_NORMAL
	    { .DEFAULT, 1, 0x181b1eff },    // DEFAULT_BASE_COLOR_NORMAL
    	{ .DEFAULT, 2, 0xc2c8d0ff },    // DEFAULT_TEXT_COLOR_NORMAL
    	{ .DEFAULT, 3, 0xd3dbdfff },    // DEFAULT_BORDER_COLOR_FOCUSED
    	{ .DEFAULT, 4, 0xa7afb0ff },    // DEFAULT_BASE_COLOR_FOCUSED
    	{ .DEFAULT, 5, 0x020202ff },    // DEFAULT_TEXT_COLOR_FOCUSED
    	{ .DEFAULT, 6, 0x181b1eff },    // DEFAULT_BORDER_COLOR_PRESSED
    	{ .DEFAULT, 7, 0xac3c3cff },    // DEFAULT_BASE_COLOR_PRESSED
    	{ .DEFAULT, 8, 0xdededeff },    // DEFAULT_TEXT_COLOR_PRESSED
    	{ .DEFAULT, 9, 0x3e4550ff },    // DEFAULT_BORDER_COLOR_DISABLED
    	{ .DEFAULT, 10, 0x2e353dff },    // DEFAULT_BASE_COLOR_DISABLED
    	{ .DEFAULT, 11, 0x484f57ff },    // DEFAULT_TEXT_COLOR_DISABLED
    	{ .DEFAULT, 16, 0x00000010 },    // DEFAULT_TEXT_SIZE 
    	{ .DEFAULT, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
    	{ .DEFAULT, 18, 0x96a3b4ff },    // DEFAULT_LINE_COLOR 
    	{ .DEFAULT, 19, 0x292c33ff },    // DEFAULT_BACKGROUND_COLOR 
    	{ .DEFAULT, 20, 0x00000008 },    // DEFAULT_TEXT_LINE_SPACING 
    	{ .LABEL, 5, 0x97a9aeff },    // LABEL_TEXT_COLOR_FOCUSED
    	{ .SLIDER, 5, 0xa69a9aff },    // SLIDER_TEXT_COLOR_FOCUSED
    	{ .SLIDER, 6, 0xc3ccd5ff },    // SLIDER_BORDER_COLOR_PRESSED
    	{ .CHECKBOX, 5, 0xa7afb0ff },    // CHECKBOX_TEXT_COLOR_FOCUSED
    	{ .CHECKBOX, 6, 0xa7aeb5ff },    // CHECKBOX_BORDER_COLOR_PRESSED
    	{ .TEXTBOX, 5, 0xa9a5a5ff },    // TEXTBOX_TEXT_COLOR_FOCUSED
    	{ .VALUEBOX, 5, 0xc9c7c7ff },    // VALUEBOX_TEXT_COLOR_FOCUSED
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
	.LAVANDA = {
    	{ .DEFAULT, 0, 0xab9bd3ff },    // DEFAULT_BORDER_COLOR_NORMAL
    	{ .DEFAULT, 1, 0x3e4350ff },    // DEFAULT_BASE_COLOR_NORMAL
    	{ .DEFAULT, 2, 0xdadaf4ff },    // DEFAULT_TEXT_COLOR_NORMAL
    	{ .DEFAULT, 3, 0xee84a0ff },    // DEFAULT_BORDER_COLOR_FOCUSED
    	{ .DEFAULT, 4, 0xf4b7c7ff },    // DEFAULT_BASE_COLOR_FOCUSED
    	{ .DEFAULT, 5, 0xb7657bff },    // DEFAULT_TEXT_COLOR_FOCUSED
    	{ .DEFAULT, 6, 0xd5c8dbff },    // DEFAULT_BORDER_COLOR_PRESSED
    	{ .DEFAULT, 7, 0x966ec0ff },    // DEFAULT_BASE_COLOR_PRESSED
    	{ .DEFAULT, 8, 0xd7ccf7ff },    // DEFAULT_TEXT_COLOR_PRESSED
    	{ .DEFAULT, 9, 0x8fa2bdff },    // DEFAULT_BORDER_COLOR_DISABLED
    	{ .DEFAULT, 10, 0x6b798dff },    // DEFAULT_BASE_COLOR_DISABLED
    	{ .DEFAULT, 11, 0x8292a9ff },    // DEFAULT_TEXT_COLOR_DISABLED
    	{ .DEFAULT, 16, 0x00000010 },    // DEFAULT_TEXT_SIZE 
    	{ .DEFAULT, 18, 0x84adb7ff },    // DEFAULT_LINE_COLOR 
    	{ .DEFAULT, 19, 0x5b5b81ff },    // DEFAULT_BACKGROUND_COLOR 
    	{ .DEFAULT, 20, 0x00000008 },    // DEFAULT_TEXT_LINE_SPACING 
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