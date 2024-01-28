extends Game

@onready var score:int = 0
@onready var lives:int = 3

const ONE_UP_SCORE = 5000



func _process(delta):
	pass

func game_randomize(seed):
	pass

func game_start():
	$RichTextLabel.text = "Started"

func game_pause():
	pass

func game_exit():
	pass
