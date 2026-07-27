package main

import rl "vendor:raylib"
import rlo "raylib_odin"
import "core:strings"
import "core:math/rand"

window_size :: [2]f32{800, 450}

font: rl.Font
FONT_SIZE :: 64

word_list: []string
active_words: [10]string

init :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(i32(window_size.x), i32(window_size.y), "Typesim")
	GuiLoadStyleCyber()

	load_font()
	load_words()
	init_words()
}

load_font :: proc() {
	data := #load("../res/Kyrou7Wide.ttf")
	font = rl.LoadFontFromMemory(".ttf", &data[0], i32(len(data)), FONT_SIZE, nil, 0)
}

// Load all words from input file into word_list.
load_words :: proc() {
	data := #load("../res/words.txt")
	str := string(data)
	words := strings.split(str, "\n")
	word_list = make([]string, len(words))
	word_list = words
}

// Fill active words.
init_words :: proc() {
	for i in 0..<len(active_words) do active_words[i] = get_random_word()
}

// Note: Random words always end with a space.
get_random_word :: proc() -> string {
	return rand.choice(word_list)
}

// Gets a string of all active words.
get_word_string :: proc() -> string {
	return strings.concatenate(active_words[:], context.temp_allocator)
}

// NOTE: Temporary!
advance_word :: proc() {
	for i in 0..<len(active_words) {
		active_words[i] = get_random_word() if i >= len(active_words) - 1 else active_words[i + 1]
	}
}

update :: proc() {
	// NOTE: Temporary
	if rl.IsKeyPressed(.K) do advance_word()
	
	rl.BeginDrawing()

	color_property := i32(rl.GuiDefaultProperty.BACKGROUND_COLOR)
	color_style := u32(rl.GuiGetStyle(.DEFAULT, color_property))
	rl.ClearBackground(rl.GetColor(color_style))

	draw_word_text()

	rl.EndDrawing()

    free_all(context.temp_allocator)
}

close :: proc() { 
	rl.CloseWindow() 
}

draw_word_text :: proc() {
	SPACING :: 1
	
	color := rl.GetColor(u32(rl.GuiGetStyle(.DEFAULT, i32(rl.GuiControlProperty.TEXT_COLOR_NORMAL))))

	text := get_word_string()
	text_size := rlo.MeasureTextEx(font, text, FONT_SIZE, SPACING)
	rlo.DrawTextPro(font, text, window_size / 2, text_size / 2, 0, FONT_SIZE, SPACING, color)
}