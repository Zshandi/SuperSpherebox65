extends Node2D

@onready
var game_loader:GameLoader = $"../GameLoader"

@onready
var game_select:GameSelect = $"../GameSelect"

func toggle_pause():
	if !get_tree().paused:
		get_tree().paused = true
		$ResumeButton.grab_focus()
		show()
		game_loader.current_game._on_game_paused()
	else:
		get_tree().paused = false
		hide()
	

func quit_game():
	game_loader.unload_current_game()
	game_select.open_menu()
	toggle_pause()
