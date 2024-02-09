extends Control

var life = preload("res://games/ShootEmUp/life.tscn")
@onready var lives_container = $Control/HBoxLivesContainer
var player_color: Color
var player_sprite: Texture2D

func update_score(score):
	var score_label = $Score
	score_label.text = "SCORE: " + str(score)
	
func update_multiplier(multiplier: int):
	var multiplier_label = $Multiplier
	if multiplier <= 1:
		multiplier_label.text = ""
		return
	multiplier_label.text = "x" + str(multiplier)
	
func update_player_health(curr_health: int):
	var player_health_bar = $PlayerHealthBar
	player_health_bar.value = curr_health
	
func update_lives(num_lives: int):
	# remove all the children
	var children = lives_container.get_children()
	for child in children:
		lives_container.remove_child(child)
		child.queue_free()
		
	# add num of lives
	for i in range(num_lives):
		var life_instantiation = life.instantiate()
		lives_container.add_child(life_instantiation)
		life_instantiation.life_icon.texture = player_sprite
		life_instantiation.life_icon.modulate = player_color
	
