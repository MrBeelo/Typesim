package main

import rl "vendor:raylib"
import "core:fmt"
import "core:strings"

VERSION :: "1.0.2"
window_size := [2]f32{800, 450}
should_close := false

log :: proc(str: string, args: ..any) { fmt.printfln(strings.concatenate({"TYPESIM: ", str}, context.temp_allocator), ..args) }

init :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT, .MSAA_4X_HINT})
	rl.InitWindow(i32(window_size.x), i32(window_size.y), "Typesim")

	load_fonts()
	load_words()
	
	init_words() // Should be done after loading words.
	init_settings()
	activate_style(settings.current_style) // Should be done after initializing settings.
}

update :: proc() {	
	window_size = {f32(rl.GetRenderWidth()), f32(rl.GetRenderHeight())}

	if !show_settings_menu do time_spent += rl.GetFrameTime()

	// We make target_char "global" here so that it can be used
	// for drawing the highlighted key on the keyboard later.
	word_string := get_word_string()
	target_char := rune(word_string[cursor_index])

	// GetCharPressed() is called every frame and always returns a
	// value, so when the user isn't pressing anything, it returns
	// a null rune. We ignore this case.
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

	// Backspace performing code
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