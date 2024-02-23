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
	
	# Instantiate the game
	current_game = game_instance_data.game_scene.instantiate()
	
	# Initialize values & connect signals
	current_game.game_instance_data = game_instance_data
	current_game.quit_game.connect(Main.pause_menu.quit_game)
	current_game.restart_game.connect(reload_current_game)
	current_game.save_game.connect(Main.save_current_game)
	
	current_game._on_game_initialized()
	
	# Load the save data
	current_game._load_save_data(Main.load_current_game())
	
	# Add it to the scene
	add_child(current_game)

func reload_current_game():
	if current_game != null:
		load_game(current_game.game_instance_data)
