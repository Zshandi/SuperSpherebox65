extends Node2D

@onready
var game_loader:GameLoader = $"../GameLoader"

@onready
var game_select:GameSelect = $"../GameSelect"

func _process(delta):
	pass

func quit_game():
	game_loader.unload_current_game()
	game_select.open_menu()
	hide()
	get_tree().paused = false
	
