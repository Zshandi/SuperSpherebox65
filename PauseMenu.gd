extends Node2D
class_name PauseMenu

func toggle_pause():
	if !get_tree().paused:
		get_tree().paused = true
		$ResumeButton.grab_focus()
		show()
		Main.game_loader.current_game._on_game_paused()
	else:
		get_tree().paused = false
		hide()
	

func quit_game():
	Main.game_loader.unload_current_game()
	Main.game_select.open_menu()
	toggle_pause()
