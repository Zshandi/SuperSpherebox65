extends Node2D
class_name Game

var has_won:bool = false
var high_score:int = 0

var game_name:String

func game_init(random_seed):
	game_name
	
func get_name_combinations() -> Array[String]:
	return []

func game_start():
	pass

func game_pause():
	pass

func game_exit():
	pass
