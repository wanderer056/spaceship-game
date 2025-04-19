extends Control

@onready var score_label = $ScoreLabel
@onready var health_bar = $HealthBar


func set_text_label(p_score) -> void:
	score_label.text = "SCORE:  " + str(p_score)
	
		
func set_health_bar_value(p_health) -> void:
	health_bar.value = p_health
	
