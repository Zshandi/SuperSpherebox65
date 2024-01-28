extends Game

var score:int = 0
var lives:int = 3

const ONE_UP_SCORE = 5000

@export
var music_arr: Array[AudioStreamWAV] = []

@onready var background_music = $BackgroundMusic
@onready var enemy_spawner = $EnemySpawner

func _ready():
	background_music.stream = music_arr.pick_random()
	background_music.play()
	enemy_spawner.connect("enemy_spawned", _on_enemy_spawned)

func _on_enemy_spawned(enemy):
	print("connecting")
	enemy.connect("enemy_died", _on_enemy_died)

func _on_enemy_died(score_to_add):
	score += score_to_add
	print("Score: " + str(score))

func _process(delta):
	pass

func game_init():
	super.game_init()

func game_start():
	super.game_start()

func game_pause():
	super.game_pause()

func game_exit():
	super.game_exit()
