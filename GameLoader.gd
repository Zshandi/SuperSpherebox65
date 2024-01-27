extends Node2D
class_name GameLoader

var current_game:Game = null

func unload_current_game():
	if current_game != null:
		current_game.game_exit()
		current_game.queue_free()
		current_game = null

func load_game(gameScene):
	unload_current_game()
	
	current_game = gameScene
	add_child(current_game)
	current_game.game_start()
