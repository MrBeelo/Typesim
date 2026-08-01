package main

Settings :: struct {
	current_style: FontStyle,
	show_keyboard: bool,
	show_key_base_color: bool,
	colored_key_borders: bool,
	split_keyboard: bool,
}

settings := Settings{
	current_style = .CYBER,
	show_keyboard = true,
	show_key_base_color = false,
	colored_key_borders = true,
	split_keyboard = true,
}