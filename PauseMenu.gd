extends Node2D
class_name PauseMenu

func toggle_pause():
	if !get_tree().paused:
		get_tree().paused = true
		$ResumeButton.grab_focus()
		show()
		%GameLoader.current_game._on_game_paused()
	else:
		get_tree().paused = false
		hide()
	

func quit_game():
	%GameLoader.unload_current_game()
	%GameSelect.open_menu()
	toggle_pause()
