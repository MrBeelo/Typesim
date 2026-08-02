package main

Settings :: struct {
	current_style: FontStyle,
	show_keyboard: bool,
	show_key_base_color: bool,
	colored_key_borders: bool,
	split_keyboard: bool,
}

settings := Settings{
	current_style = .HEXAMANIA,
	show_keyboard = true,
	show_key_base_color = true,
	colored_key_borders = false,
	split_keyboard = true,
}