class_name PlayerBase extends CharacterBody2D

signal player_killed()
signal player_damaged(health)

@export var boost_speed: int = 700
@export var agility: int = 300
@export var health: int = 100

var normal_speed = 200
var config = ConfigFile.new()

@onready var player_sprite = $Sprite2D
@onready var camera = $Camera2D 


func get_input() -> void:
	var horizontal_direction = (Input.get_action_strength("move_right")-Input.get_action_strength("move_left"))
	velocity.x = horizontal_direction * agility
	velocity.y = -normal_speed
	if Input.is_action_pressed("speed_up"):
		velocity.y = -boost_speed
	if Input.is_action_just_released("speed_up"):
		velocity.y = -normal_speed

	global_position.x = clamp(global_position.x,80,920)
	

func _physics_process(delta) -> void:
	get_input()
	move_and_slide()


func die() -> void:
	player_killed.emit()
	queue_free()

	
func take_damage(p_damage_points) -> void:
	health -= p_damage_points
	if health <=0:
		health = 0
		die()
	player_damaged.emit(health)
	
	
func set_camera_position(p_position) -> void:
	camera.position = p_position
