package main

import "core:strings"
import "core:math/rand"

word_list: []string

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