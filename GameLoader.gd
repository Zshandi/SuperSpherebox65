extends Node2D
class_name GameLoader

var current_game:Game = null
signal start_menu_music

func unload_current_game():
	if current_game != null:
		current_game.game_exit()
		current_game.queue_free()
		current_game = null
		emit_signal("start_menu_music")

func load_game(game_instance_data):
	unload_current_game()
	
	current_game = game_instance_data.game_scene.instantiate()
	current_game.game_instance_data = game_instance_data
	current_game.game_init()
	add_child(current_game)
	current_game.game_start()
