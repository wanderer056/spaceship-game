extends "res://entity/Enemy/base_enemy.gd"

var horizontal_speed


func _ready() -> void:
	if global_position.x < 500:
		horizontal_speed = 200
		rotation_degrees = -25
	elif global_position.x >= 500:
		horizontal_speed = -200
		rotation_degrees = 25


func _physics_process(p_delta) -> void:
	global_position.y += base_speed * speed * p_delta
	global_position.x += horizontal_speed * p_delta
		
