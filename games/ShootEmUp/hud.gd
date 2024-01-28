extends Control

func update_score(score):
	var score_label = $Score
	score_label.text = "SCORE: " + str(score)
