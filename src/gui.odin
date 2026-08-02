package main

import rl "vendor:raylib"

show_settings_menu: bool

draw_gui :: proc() {
	clicked := rl.GuiButton({10, 10, 100, 50}, "#142#Settings")
	if clicked do show_settings_menu = !show_settings_menu

	if show_settings_menu {
		menu_size := rl.Vector2{300, 400}
		menu_rec := rl.Rectangle{window_size.x / 2 - menu_size.x / 2, window_size.y / 2 - menu_size.y / 2, menu_size.x, menu_size.y}

		menu_state := rl.GuiWindowBox(menu_rec, "Settings")
		if menu_state == 1 do show_settings_menu = false
	}
}