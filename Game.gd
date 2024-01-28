extends Node2D
class_name Game

var has_won:bool = false
var high_score:int = 0

var game_instance_data:GameInstanceData

func game_init():
	seed(game_instance_data.random_seed)

func game_start():
	pass

func game_pause():
	pass

func game_exit():
	pass
