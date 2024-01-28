extends Game

@export
var possible_good_fortunes: Array[String] = []
var good_fortune_to_use: String

@export
var possible_bad_fortunes: Array[String] = []
var bad_fortune_to_use: String

@export
var possible_uncertain_fortunes: Array[String] = []
var uncertain_fortune_to_use: String


@onready var background = $ScrollingBackground
@onready var color_rect = $ColorRect

func _ready():
	background.sprite.modulate = Color(randf(),randf(),randf(),1)
	background.color_rect.color = Color(randf(),randf(),randf(),1)
	
	# grab fortunes
	good_fortune_to_use = possible_good_fortunes.pick_random()
	bad_fortune_to_use = possible_bad_fortunes.pick_random()
	uncertain_fortune_to_use = possible_uncertain_fortunes.pick_random()
	
	_randomize_fortune()
	
	
func _process(delta):
	var game_over = $GameOver
	if Input.is_action_just_pressed("six") and not game_over.is_visible():
		game_over.show()
	elif Input.is_action_just_pressed("six") and game_over.is_visible():
		game_over.hide()
		_randomize_fortune()
		
func _randomize_fortune():
	var fortunes = [
		good_fortune_to_use, bad_fortune_to_use, uncertain_fortune_to_use
	]
	
	var game_over = $GameOver
	game_over.set_fortune(fortunes.pick_random())
	
	
	
