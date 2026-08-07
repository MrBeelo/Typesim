package main

import rl "vendor:raylib"
import "core:fmt"

// Generic
UI_BUFFER :: 10

// Buttons
MAIN_UI_SIZE :: 36

// Settings menu
TOP_BAR_HEIGHT :: 24
ELEMENT_BUFFER :: 5
ELEMENT_HEIGHT :: 36
TOGGLE_WIDTH :: 100
COMBO_BOX_WIDTH :: 120

show_settings_menu: bool

// Draws all UI elements, for both the main screen and the settings menu.
draw_gui :: proc() {
	draw_text_centered(get_font(.STYLE), fmt.ctprintf("TYPESIM - %s", VERSION), {window_size.x / 2, 20}, 0,
		get_font_size(.STYLE), text_spacing(.STYLE), text_color())
	
	if add_button(0, true, "#142#", "Settings") do show_settings_menu = !show_settings_menu
	if add_button(1, true, "#6#", "Save Settings") do save_settings()
	if add_button(0, false, "#113#", "Exit") do should_close = true

	if show_settings_menu {
		menu_size := rl.Vector2{250, 9 * (ELEMENT_HEIGHT + ELEMENT_BUFFER) + ELEMENT_BUFFER + TOP_BAR_HEIGHT}
		menu_rec := rl.Rectangle{window_size.x / 2 - menu_size.x / 2, window_size.y / 2 - menu_size.y / 2, menu_size.x, menu_size.y}

		menu_state := rl.GuiWindowBox(menu_rec, "Settings")
		if menu_state == 1 do show_settings_menu = false

		// CURRENT STYLE
		{
			options: cstring = "Amber;Cherry;Cyber;Default;Enefete;Genesis;Hexamania;Jungle;Lavanda;Terminal"
			new := add_combo_box(menu_rec, 0, "GUI Style", options, Font_Style, settings.current_style)
			if settings.current_style != new do activate_style(new)
		}

		// KEYBOARD SETTINGS
		{
			add_toggle(menu_rec, 1.5, "Show Keyboard", "No;Yes", &settings.show_keyboard)
			
			if !settings.show_keyboard do rl.GuiDisable()
			add_toggle(menu_rec, 2.5, "Key Base Color", "No;Yes", &settings.show_key_base_color)
			add_toggle(menu_rec, 3.5, "Colored Keys", "No;Yes", &settings.colored_key_borders)
			add_toggle(menu_rec, 4.5, "Split Keyboard", "No;Yes", &settings.split_keyboard)
			add_toggle(menu_rec, 5.5, "Highlight Target Key", "No;Yes", &settings.highlight_target_key)
			rl.GuiEnable()
		}

		// WPM FORMAT
		settings.wpm_format = add_combo_box(menu_rec, 7, "WPM Format", "Per Letter;Per Word;Average", 
			WPM_Format, settings.wpm_format)

		// VIEW TARGET LETTER
		add_toggle(menu_rec, 8, "Judgement View", "Typed;Target", &settings.view_target_letter)
	}
}

// Adds a default button, using the index system (horizontal). Returns true when clicked.
add_button :: proc(index: f32, left: bool, text: cstring, tooltip: cstring) -> bool {
	x_pos := UI_BUFFER + index * (UI_BUFFER + MAIN_UI_SIZE)
	if !left do x_pos = window_size.x - MAIN_UI_SIZE - x_pos

	rl.GuiSetTooltip(tooltip)
	rl.GuiEnableTooltip()
	
	rec := rl.Rectangle{x_pos, UI_BUFFER, MAIN_UI_SIZE, MAIN_UI_SIZE}
	clicked := rl.GuiButton(rec, text)

	rl.GuiDisableTooltip()
	
	return clicked
}

// FOR SETTINGS MENU ONLY

// Adds a default combo box. As it was needed, this just returns the new value,
// so it doesn't take any pointers. T should be an enum.
add_combo_box :: proc(menu: rl.Rectangle, index: f32, label_text: cstring, combo_box_text: cstring, $T: typeid, value: T) -> T {	
	label_rec := get_label_rec(menu, index)
	rl.GuiLabel(label_rec, label_text)

	combo_box_rec := get_box_rec(menu, label_rec.y, COMBO_BOX_WIDTH)
	new_value := i32(value)
	rl.GuiComboBox(combo_box_rec, combo_box_text, &new_value)
	return T(new_value)
}

// Adds a default toggle. Directly changes the value at the bool pointer.
add_toggle :: proc(menu: rl.Rectangle, index: f32, label_text: cstring, toggle_text: cstring, value: ^bool) {
	label_rec := get_label_rec(menu, index)
	rl.GuiLabel(label_rec, label_text)

	toggle_rec := get_box_rec(menu, label_rec.y, TOGGLE_WIDTH)
	active := i32(value^)
	rl.GuiToggleSlider(toggle_rec, toggle_text, &active)
	value^ = bool(active)
}

// Gets the bounds of a label, using the index system.
get_label_rec :: proc(menu: rl.Rectangle, index: f32) -> rl.Rectangle {
	return rl.Rectangle{menu.x + ELEMENT_BUFFER, get_element_y(menu.y, index), menu.width - ELEMENT_BUFFER * 2, ELEMENT_HEIGHT}
}

// Gets the bounds of a "box", which in this case is either a toggle or
// a combo box, using its corresponding label. 
get_box_rec :: proc(menu: rl.Rectangle, label_y: f32, width: f32) -> rl.Rectangle {
	return rl.Rectangle{menu.x + menu.width - ELEMENT_BUFFER - width, label_y, width, ELEMENT_HEIGHT}
}

// Gets an element's Y position based on the index system.
get_element_y :: proc(menu_y: f32, index: f32) -> f32 {
	return menu_y + ELEMENT_BUFFER + TOP_BAR_HEIGHT + (ELEMENT_HEIGHT + ELEMENT_BUFFER) * f32(index)
}