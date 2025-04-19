extends Control

var rocket_data = {}
var config = ConfigFile.new()
var currently_selected

@onready var rocket_name_label = $RocketName
@onready var description_label = $HBoxContainer2/VBoxContainer/DescriptionLabel
@onready var speed_label = $HBoxContainer2/VBoxContainer2/VBoxContainer/SpeedLabel
@onready var health_label = $HBoxContainer2/VBoxContainer2/VBoxContainer/HealthLabel
@onready var agility_label = $HBoxContainer2/VBoxContainer2/VBoxContainer/AgilityLabel
@onready var rocket1_button = $HBoxContainer/Rocket1
@onready var rocket2_button = $HBoxContainer/Rocket2
@onready var rocket3_button = $HBoxContainer/Rocket3


func _ready() -> void:

	var err = config.load("res://utils/rocket_data.cfg")
	if err != OK:
		print("Error")
	for rocket in config.get_sections():
		var a_dict = {}
		a_dict["name"] = config.get_value(rocket,"name")
		a_dict["health"] = config.get_value(rocket,"health")
		a_dict["agility"] = config.get_value(rocket,"agility")
		a_dict["speed"] = config.get_value(rocket,"speed")
		a_dict["description"] = config.get_value(rocket,"description")
		rocket_data[rocket] = a_dict
	
	config.load("user://utils/rocket_selected.cfg")
	var current_rocket = config.get_value("current","selected_rocket")
	set_label_data(rocket_data[current_rocket])
	
	set_pressed_buttons(current_rocket)


func set_pressed_buttons(p_button_name) -> void:
	if p_button_name == "Rocket1":
		rocket1_button.set_pressed_no_signal(true)
	elif p_button_name == "Rocket2":
		rocket2_button.set_pressed_no_signal(true)
	elif p_button_name == "Rocket3":
		rocket3_button.set_pressed_no_signal(true)	

	
func set_label_data(p_rocket_data) -> void:
	rocket_name_label.text = p_rocket_data["name"]
	description_label.text = p_rocket_data["description"]
	speed_label.text = "SPEED: " + str(p_rocket_data["speed"])
	agility_label.text = "AGILITY: " + str(p_rocket_data["agility"])
	health_label.text = "HEALTH: " + str(p_rocket_data["health"])
	
	currently_selected = p_rocket_data["name"].replace(" ","")


func _on_rocket_1_pressed() -> void:
	set_label_data(rocket_data["Rocket1"])


func _on_rocket_2_pressed() -> void:
	set_label_data(rocket_data["Rocket2"])


func _on_rocket_3_pressed() -> void:
	set_label_data(rocket_data["Rocket3"])


func _on_back_button_pressed() -> void:
	var config = ConfigFile.new()
	config.set_value("current","selected_rocket",currently_selected)
	config.save("user://utils/rocket_selected.cfg")
	get_tree().change_scene_to_file("res://main_menu.tscn")	
		
