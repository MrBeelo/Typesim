package main

import "core:strings"
import "core:math/rand"

word_list: []string
avg_word_length: f32

// Loads all words from input file into word_list.
load_words :: proc() {
	data := #load("../res/words.txt")
	str := string(data)
	words := strings.split(str, "\n")
	word_list = make([]string, len(words))
	word_list = words
}

// Fills active words.
init_words :: proc() {
	for i in 0..<len(active_words) do active_words[i] = get_random_word()

	total_word_length: int
	for word in word_list do total_word_length += len(word)
	avg_word_length = f32(total_word_length) / f32(len(word_list))
}

// Gets a random word from the word list.
// Note: Random words should always end with a space.
get_random_word :: proc() -> string {
	return rand.choice(word_list)
}