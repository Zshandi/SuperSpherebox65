extends Control


func update_score(score):
	var score_label = $Score
	score_label.text = "SCORE: " + str(score)
	
func update_multiplier(multiplier: int):
	var multiplier_label = $Multiplier
	if multiplier <= 1:
		multiplier_label.text = ""
		return
	multiplier_label.text = "x" + str(multiplier)
	
func update_player_health(curr_health: int):
	var player_health_bar = $PlayerHealthBar
	player_health_bar.value = curr_health
