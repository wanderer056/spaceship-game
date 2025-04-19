extends Area2D

signal enemy_screen_exited(score_points)

@export var speed: int  = 1
@export var enemy_rotation: float = 0
@export var damage: float = 20
@export var score_points: int = 5

var base_speed = 300


func _physics_process(p_delta) -> void:
	global_position.y += base_speed * speed * p_delta
	rotation += enemy_rotation * p_delta

func die() -> void:
	queue_free()
	

func _on_body_entered(p_body) -> void:
	if p_body is PlayerBase:
		p_body.take_damage(damage)
		die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	enemy_screen_exited.emit(score_points)
	
