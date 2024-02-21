extends Panel

signal restart_game
signal quit_game

func update_score(score: int) -> void:
	var score_label = $ScoreLabel
	score_label.text = "Youre score: " + str(score)
	
func show_game_over() -> void:
	show()
	$RetryButton.grab_focus()

func _on_retry_button_pressed() -> void:
	emit_signal("restart_game")
	
func _on_quit_button_pressed() -> void:
	emit_signal("quit_game")
