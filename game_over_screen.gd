extends Control

@onready var highscore_label = $Panel/GameOverVerticalContainer/HighscoreLabel
@onready var score_label_GOS = $Panel/GameOverVerticalContainer/ScoreLabel


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	AudioManager.play_button_click()
	

func _on_home_button_pressed() -> void:
	AudioManager.play_button_click()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func set_high_score(p_value) -> void:
	highscore_label.text = "HIGH SCORE: " + str(p_value)


func set_score(p_value) -> void:
	score_label_GOS.text = "SCORE: " + str(p_value)
