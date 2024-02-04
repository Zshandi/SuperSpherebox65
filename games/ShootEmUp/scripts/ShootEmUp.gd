extends Game

var score:int = 0
var lives:int = 3

const ONE_UP_SCORE = 5000

@export
var music_arr: Array[AudioStreamWAV] = []

@onready var background_music = $BackgroundMusic
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $HUD
@onready var player_spawn_position = %PlayerSpawnPosition
@onready var player_health_bar = %PlayerHealthBar

var player = preload("res://games/ShootEmUp/Player.tscn")
var player_sprite: Texture2D
var player_color: Color

func _ready():
	background_music.stream = music_arr.pick_random()
	background_music.play()
	enemy_spawner.connect("enemy_spawned", _on_enemy_spawned)
	player_sprite = player.instantiate().player_sprite_arr.pick_random()
	player_color = Main.random_color()
	_spawn_player()
	
func _spawn_player():
	var player_instantiation = player.instantiate()
	player_instantiation.global_position = player_spawn_position.global_position
	player_instantiation.connect("player_take_damage", _on_player_player_take_damage)
	player_instantiation.connect("player_died", _on_player_died)
	player_health_bar.value = player_instantiation.health
	add_child(player_instantiation)
	player_instantiation.player_sprite.texture = player_sprite
	player_instantiation.player_sprite.modulate = player_color

func _on_enemy_spawned(enemy):
	enemy.connect("enemy_died", _on_enemy_died)

func _on_enemy_died(score_to_add):
	score += score_to_add
	print("Score: " + str(score))
	hud.update_score(score)

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

func _on_player_player_take_damage(curr_health):
	print("Updating GUI")
	player_health_bar.value = curr_health

func _on_player_died():
	print("Player died")
	lives -= 1
	if lives <= 0:
		print("Game Over")
	else:
		await get_tree().create_timer(1.5).timeout
		_spawn_player()
