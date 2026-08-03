package main

import "core:encoding/json"
import "utils"

WPM_Format :: enum{ CHAR_ONLY, WORD_ONLY, CHAR_WORD_AVG }

settings: Settings
SETTINGS_PATH :: string("typesim-settings.json")

Settings :: struct {
	current_style: Font_Style,
	show_keyboard: bool,
	show_key_base_color: bool,
	colored_key_borders: bool,
	split_keyboard: bool,
	highlight_target_key: bool,
	wpm_format: WPM_Format,
	view_target_letter: bool,
}

init_settings :: proc() {
	settings = default_settings()
	
	data, ok := utils.read_entire_file(SETTINGS_PATH)
	if !ok do return
	
	err := json.unmarshal(data, &settings)
	if err != nil { log("JSON Unarshal error!"); return }
	log("Loading settings file!")
}

save_settings :: proc() {
	opts := json.Marshal_Options{.JSON, true, false, 0, false, false, false, false, false, 0, false, false}
	
	data, err := json.marshal(settings, opts)
	if err != nil { log("JSON Marshal error!"); return }

	log("Saving settings file!")
	utils.write_entire_file(SETTINGS_PATH, data)
}

default_settings :: proc "contextless" () -> Settings {
	return Settings{
		current_style = .HEXAMANIA,
		show_keyboard = true,
		show_key_base_color = true,
		colored_key_borders = true,
		split_keyboard = true,
		highlight_target_key = true,
		wpm_format = .CHAR_WORD_AVG,
		view_target_letter = true,
	}
}