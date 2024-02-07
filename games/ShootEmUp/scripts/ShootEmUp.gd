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

var player = preload("res://games/ShootEmUp/Player.tscn")
var player_sprite: Texture2D
var player_shoot_audio: AudioStreamWAV
var player_hurt_audio: AudioStreamWAV
var player_death_audio: AudioStreamWAV
var player_color: Color
var player_speed: float
var player_shoot_speed: float

var enemies_killed = 0
const ENEMY_KILLED_MULTIPLIER = 5
@onready var combo_timer = %ComboTimer
var curr_multiplier: int

@onready var game_over = $UI/GameOver

func _ready():
	game_over.hide()
	background_music.stream = music_arr.pick_random()
	background_music.play()
	enemy_spawner.connect("enemy_spawned", _on_enemy_spawned)
	var instant = player.instantiate()
	player_sprite = instant.player_sprite_arr.pick_random()
	player_shoot_audio = instant.shoot_audio_arr.pick_random()
	player_hurt_audio = instant.hurt_audio_arr.pick_random()
	player_death_audio = instant.hurt_audio_arr.pick_random()
	player_color = Main.random_color()
	player_speed = randi_range(100,600)
	player_shoot_speed = randi_range(50,5000)
	combo_timer.connect("timeout", _on_combo_timeout)
	_spawn_player()
	_update_multiplier()
	
func _spawn_player():
	var player_instantiation = player.instantiate()
	player_instantiation.global_position = player_spawn_position.global_position
	player_instantiation.connect("player_take_damage", _on_player_player_take_damage)
	player_instantiation.connect("player_died", _on_player_died)
	hud.update_player_health(player_instantiation.health)
	add_child(player_instantiation)
	player_instantiation.player_sprite.texture = player_sprite
	player_instantiation.player_sprite.modulate = player_color
	player_instantiation.speed = player_speed
	player_instantiation.fire_speed = player_shoot_speed
	player_instantiation.shoot_audio.stream = player_shoot_audio
	player_instantiation.hurt_audio.stream = player_hurt_audio
	player_instantiation.death_audio.stream = player_death_audio

func _on_enemy_spawned(enemy):
	enemy.connect("enemy_died", _on_enemy_died)

func _on_enemy_died(score_to_add):
	_update_multiplier()
	_update_score(score_to_add)

func _update_multiplier():
	combo_timer.stop()
	enemies_killed += 1
	curr_multiplier = ceil(float(enemies_killed) / ENEMY_KILLED_MULTIPLIER)
	hud.update_multiplier(curr_multiplier)
	combo_timer.start()
	
func _on_combo_timeout():
	enemies_killed = 0
	_update_multiplier()
	
	
func _update_score(score_to_add):
	var new_score_to_add = score_to_add * curr_multiplier
	score += new_score_to_add
	hud.update_score(score)
	game_over.update_score(score)
	

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
	hud.update_player_health(curr_health)
	#hud.player_health_bar.value = curr_health

func _on_player_died():
	print("Player died")
	combo_timer.stop()
	_on_combo_timeout()
	lives -= 1
	if lives <= 0:
		print("Game Over")
		game_over.show()
	else:
		_spawn_player()
