extends Game

var score:int = 0
var lives:int = 3

const ONE_UP_SCORE = 5000

@export
var music_arr: Array[AudioStreamWAV] = []

@onready var background_music = $BackgroundMusic
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $HUD

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
	hud.update_score(score)

func _process(delta):
	pass

func _on_game_initialized():
	super._on_game_initialized()

func _on_game_paused():
	super._on_game_paused()

func _on_game_quit():
	super._on_game_quit()
