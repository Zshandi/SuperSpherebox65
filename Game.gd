extends Node2D
class_name Game

var has_won:bool = false
var high_score:int = 0

var game_name:String
@onready var game_instance_data:GameInstanceData = preload("res://GameInstanceData.gd").new()

func game_init(random_seed):
	#game_name
	var rand = game_instance_data.get_new_random_generator()
	print(rand)
	
	
func get_name_combinations() -> Array[String]:
	return []

func game_start():
	pass

func game_pause():
	pass

func game_exit():
	pass
