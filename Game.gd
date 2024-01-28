extends Node2D
class_name Game

var has_won:bool = false
var high_score:int = 0

var game_instance_data:GameInstanceData

var random_generator:RandomNumberGenerator

func game_init():
	random_generator = game_instance_data.get_new_random_generator()

func game_start():
	pass

func game_pause():
	pass

func game_exit():
	pass
