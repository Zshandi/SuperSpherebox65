extends Node2D
class_name GameLoader

var current_game:Game = null

func unload_current_game():
	if current_game != null:
		current_game._on_game_quit()
		current_game.queue_free()
		current_game = null

func load_game(game_instance_data):
	unload_current_game()
	
	current_game = game_instance_data.game_scene.instantiate()
	current_game.game_instance_data = game_instance_data
	#current_game.quit_game.connect($"../PauseMenu".quit_game)
	current_game.quit_game.connect($"../CanvasLayer/PauseMenu".quit_game)
	current_game.restart_game.connect(reload_current_game)
	# TODO [#5]: Add save_game method to connect here
	#current_game.save_game.connect(%Main.save_gave)
	current_game._on_game_initialized()
	add_child(current_game)

func reload_current_game():
	if current_game != null:
		var current_instance_data := current_game.game_instance_data
		unload_current_game()
		load_game(current_instance_data)
