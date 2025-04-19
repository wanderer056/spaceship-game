extends Node

@onready var button_sound = $ButtonSound
@onready var game_over_sound = $GameOverSound
@onready var hit_sound = $HitSound
@onready var bgm = $BGM


func play_button_click() -> void:
	button_sound.play()
	
	
func play_game_over() -> void:
	game_over_sound.play()


func play_hit_sound() -> void:
	hit_sound.play()
