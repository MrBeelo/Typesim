package main

import rl "vendor:raylib"

UI_BUFFER :: 10
TOP_BAR_HEIGHT :: 24
ELEMENT_BUFFER :: 5
ELEMENT_HEIGHT :: 36

TOGGLE_WIDTH :: 100
COMBO_BOX_WIDTH :: 120

MAIN_UI_SIZE :: 36

show_settings_menu: bool

draw_gui :: proc() {
	settings_rec := rl.Rectangle{UI_BUFFER, UI_BUFFER, MAIN_UI_SIZE, MAIN_UI_SIZE}
	settings_clicked := rl.GuiButton(settings_rec, "#142#")
	if settings_clicked do show_settings_menu = !show_settings_menu

	save_rec := rl.Rectangle{MAIN_UI_SIZE + UI_BUFFER * 2, UI_BUFFER, MAIN_UI_SIZE, MAIN_UI_SIZE}
	save_clicked := rl.GuiButton(save_rec, "#6#")
	if save_clicked do save_settings()

	exit_rec := rl.Rectangle{window_size.x - UI_BUFFER - MAIN_UI_SIZE, UI_BUFFER, MAIN_UI_SIZE, MAIN_UI_SIZE}
	exit_clicked := rl.GuiButton(exit_rec, "#113#")
	if exit_clicked do should_close = true

	if show_settings_menu {
		menu_size := rl.Vector2{250, 9 * (ELEMENT_HEIGHT + ELEMENT_BUFFER) + ELEMENT_BUFFER + TOP_BAR_HEIGHT}
		menu_rec := rl.Rectangle{window_size.x / 2 - menu_size.x / 2, window_size.y / 2 - menu_size.y / 2, menu_size.x, menu_size.y}

		menu_state := rl.GuiWindowBox(menu_rec, "Settings")
		if menu_state == 1 do show_settings_menu = false

		// CURRENT STYLE
		{
			options: cstring = "Amber;Cherry;Cyber;Enefete;Genesis;Hexamania;Jungle;Lavanda;Terminal"
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

// Note: This should probably take an enum (for T).
add_combo_box :: proc(start: rl.Rectangle, index: f32, label_text: cstring, combo_box_text: cstring, $T: typeid, value: T) -> T {	
	label_rec := get_label_rec(start, index)
	rl.GuiLabel(label_rec, label_text)

	combo_box_rec := get_box_rec(start, label_rec.y, COMBO_BOX_WIDTH)
	new_value := i32(value)
	rl.GuiComboBox(combo_box_rec, combo_box_text, &new_value)
	return T(new_value)
}

add_toggle :: proc(start: rl.Rectangle, index: f32, label_text: cstring, toggle_text: cstring, value: ^bool) {
	label_rec := get_label_rec(start, index)
	rl.GuiLabel(label_rec, label_text)

	toggle_rec := get_box_rec(start, label_rec.y, TOGGLE_WIDTH)
	active := i32(value^)
	rl.GuiToggleSlider(toggle_rec, toggle_text, &active)
	value^ = bool(active)
}

get_label_rec :: proc(start: rl.Rectangle, index: f32) -> rl.Rectangle {
	return rl.Rectangle{start.x + ELEMENT_BUFFER, get_element_y(start.y, index), start.width - ELEMENT_BUFFER * 2, ELEMENT_HEIGHT}
}

get_box_rec :: proc(start: rl.Rectangle, label_y: f32, width: f32) -> rl.Rectangle {
	return rl.Rectangle{start.x + start.width - ELEMENT_BUFFER - width, label_y, width, ELEMENT_HEIGHT}
}

get_element_y :: proc(start_y: f32, index: f32) -> f32 {
	return start_y + ELEMENT_BUFFER + TOP_BAR_HEIGHT + (ELEMENT_HEIGHT + ELEMENT_BUFFER) * f32(index)
}