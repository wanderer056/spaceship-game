extends Control

@onready var animation_player = $AnimationPlayer
@onready var progress_timer = $ProgressTimer
@onready var progress_bar = $ProgressBar


func _on_animation_player_animation_finished(p_anim_name) -> void:
	progress_timer.start()


func _on_progress_timer_timeout() -> void:
	progress_bar.value += 3


func _on_progress_bar_value_changed(p_value) -> void:
	if p_value == 100:
		get_tree().change_scene_to_file("res://main_menu.tscn")
