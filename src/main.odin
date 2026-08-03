package main

import rl "vendor:raylib"
import "core:fmt"

window_size := [2]f32{800, 450}
should_close := false

log :: fmt.printf

init :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT, .MSAA_4X_HINT})
	rl.InitWindow(i32(window_size.x), i32(window_size.y), "Typesim")

	load_fonts()
	load_words()
	
	init_words()
	activate_style(settings.current_style)
}

update :: proc() {	
	window_size = {f32(rl.GetRenderWidth()), f32(rl.GetRenderHeight())}
	
	word_string := get_word_string()
	target_char := rune(word_string[cursor_index])
	
	char_pressed := rl.GetCharPressed()
	if char_pressed != rune(0) && !show_settings_menu {
		append_typed_char(char_pressed, target_char)

		char_type_times[0] = char_type_times[1]
		char_type_times[1] = f32(rl.GetTime())

		// If target character is a space, do word advancing stuff
		if target_char == ' ' {
			cursor_index -= len(active_words[0])
			advance_word()

			word_type_times[0] = word_type_times[1]
			word_type_times[1] = f32(rl.GetTime())
		}
		
		cursor_index += 1

		characters_typed += 1
		if char_pressed == target_char do correct_characters_typed += 1
	}

	if rl.IsKeyPressed(.BACKSPACE) && can_perform_backspace() && !show_settings_menu {
		if rl.IsKeyDown(.LEFT_CONTROL) {
			// If ctrl+backspace, delete whole word.
			for can_perform_backspace() do perform_backspace()
		} else {
			// Just backspace, delete last character.
			perform_backspace()
		}
	}
		
	rl.BeginDrawing()

	rl.ClearBackground(background_color())
	
	draw_word_text()
	draw_typed_chars()
	draw_cursor()
	draw_stats()
	draw_keyboard(target_char)
	draw_gui()

	rl.EndDrawing()

    free_all(context.temp_allocator)
}

close :: proc() { 
	rl.CloseWindow() 
}