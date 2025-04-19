extends Node2D

@export var rockets_scene : PackedScene
@export var enemy_scenes : Array[PackedScene] =[]
@export var scroll_speed : int = 100

var score = 0
var player_killed : bool
var high_score
var wait_time_cap = 0.1
var player

@onready var player_spawn_pos = $PlayerSpawnPosition
@onready var enemy_container = $EnemyContainer   
@onready var HUD = $CanvasLayer/HUD
@onready var game_over_screen = $CanvasLayer/GameOverScreen
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var parallax_background = $ParallaxBackground


func _ready() -> void:
	var current_rocket_preload
	
	var config = ConfigFile.new()
	config.load("user://utils/rocket_selected.cfg")
	
	var save_file = FileAccess.open("user://save.data",FileAccess.READ)


	var current_rocket= config.get_value("current","selected_rocket")
	if current_rocket == "Rocket1":
		current_rocket_preload = preload("res://entity/Rockets/rocket_1.tscn")
	elif current_rocket == "Rocket2":
		current_rocket_preload = preload("res://entity/Rockets/rocket_2.tscn")
	elif current_rocket == "Rocket3":
		current_rocket_preload = preload("res://entity/Rockets/rocket_3.tscn")
		
	player = current_rocket_preload.instantiate()
	add_child(player)
	
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	player.global_position.x = player_spawn_pos.global_position.x
	HUD.set_text_label(score)
	
	player.player_killed.connect(_on_player_killed)
	player.player_damaged.connect(_on_player_damaged)
	
	game_over_screen.visible = false


func save_game() -> void:
	var save_file = FileAccess.open("user://save.data",FileAccess.WRITE)
	save_file.store_32(high_score)	


func _process(p_delta) -> void:
	
#	if enemy_spawn_timer.wait_time > wait_time_cap:
#		enemy_spawn_timer.wait_time -= p_delta * 0.005
#	elif enemy_spawn_timer.wait_time < wait_time_cap:
#		enemy_spawn_timer.wait_time = 0.1
	if player_killed:
		parallax_background.scroll_offset.y += scroll_speed * p_delta
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://main_menu.tscn")
		
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		


func _on_enemy_spawn_timer_timeout() -> void:
		var current_enemy = enemy_scenes.pick_random().instantiate()
#		var current_enemy = enemy_scenes[repeat].instantiate()		
		current_enemy.global_position = Vector2(randf_range(50,950),player.position.y - 1300)
		current_enemy.enemy_screen_exited.connect(_on_enemy_screen_exited)
		enemy_container.add_child(current_enemy)   

	
func _on_enemy_screen_exited(p_score_points) -> void:
	if !player_killed:
		score += p_score_points
		HUD.set_text_label(score)
	
	
func _on_player_killed() -> void:
	game_over_screen.set_score(score)
	if score > high_score:
		high_score = score
	game_over_screen.set_high_score(high_score)
	save_game()
	player_killed = true
	AudioManager.play_game_over()
	enemy_spawn_timer.stop()
	await get_tree().create_timer(0.5).timeout
	game_over_screen.visible = true


func _on_player_damaged(p_health) -> void:
	AudioManager.play_hit_sound()
	HUD.set_health_bar_value(p_health)
	
	
