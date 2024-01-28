extends Game

@onready var score:int = 0
@onready var lives:int = 3

const ONE_UP_SCORE = 5000

@export
var music_arr: Array[AudioStreamWAV] = []

@onready var background_music = $BackgroundMusic

func _ready():
	background_music.stream = music_arr.pick_random()
	background_music.play()

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
