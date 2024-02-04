extends Panel

func update_score(score):
	var score_label = $ScoreLabel
	score_label.text = "Youre score: " + str(score)
