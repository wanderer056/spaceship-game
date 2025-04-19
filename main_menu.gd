extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_raptor_select_button_pressed():
	get_tree().change_scene_to_file("res://selection_screen.tscn")
