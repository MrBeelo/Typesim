package main

WPM_Format :: enum{ CHAR_ONLY, WORD_ONLY, CHAR_WORD_AVG }

Settings :: struct {
	current_style: Font_Style,
	show_keyboard: bool,
	show_key_base_color: bool,
	colored_key_borders: bool,
	split_keyboard: bool,
	wpm_format: WPM_Format,
	view_target_letter: bool,
}

settings := Settings{
	current_style = .HEXAMANIA,
	show_keyboard = true,
	show_key_base_color = true,
	colored_key_borders = true,
	split_keyboard = true,
	wpm_format = .CHAR_WORD_AVG,
	view_target_letter = true,
}