package main

import rl "vendor:raylib"

window_size :: [2]f32{1920, 1080}

init :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(i32(window_size.x), i32(window_size.y), "Typesim")
	GuiLoadStyleCyber()

	load_fonts()
	load_words()
	init_words()
}

update :: proc() {	
	char_pressed := rl.GetCharPressed()
	if char_pressed != rune(0) {
		word_string := get_word_string()
		target_char := rune(word_string[cursor_index])
		
		append_typed_char(char_pressed, target_char)
		
		if target_char == ' ' {
			cursor_index -= len(active_words[0])
			advance_word()

			type_times[0] = type_times[1]
			type_times[1] = f32(rl.GetTime())
		}
		
		cursor_index += 1

		characters_typed += 1
		if char_pressed == target_char do correct_characters_typed += 1
	}
		
	rl.BeginDrawing()

	rl.ClearBackground(rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiDefaultProperty.BACKGROUND_COLOR)))))
	
	draw_word_text()
	draw_typed_chars()
	draw_cursor()
	draw_stats()

	rl.EndDrawing()

    free_all(context.temp_allocator)
}

close :: proc() { 
	rl.CloseWindow() 
}