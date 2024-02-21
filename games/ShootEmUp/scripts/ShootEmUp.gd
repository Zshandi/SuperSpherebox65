extends Game

var score:int = 0
var lives:int = 3

const ONE_UP_SCORE = 5000

@export
var music_arr: Array[AudioStreamWAV] = []

@onready var background_music = $BackgroundMusic
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $UI/HUD
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
	hud.player_sprite = player_sprite
	hud.player_color = player_color
	hud.update_lives(lives)
	
func _spawn_player() -> void:
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

func _on_enemy_spawned(enemy) -> void:
	enemy.connect("enemy_died", _on_enemy_died)

func _on_enemy_died(score_to_add) -> void:
	_update_multiplier()
	_update_score(score_to_add)

func _update_multiplier() -> void:
	combo_timer.stop()
	enemies_killed += 1
	curr_multiplier = ceil(float(enemies_killed) / ENEMY_KILLED_MULTIPLIER)
	hud.update_multiplier(curr_multiplier)
	combo_timer.start()
	
func _on_combo_timeout() -> void:
	enemies_killed = 0
	_update_multiplier()
	
	
func _update_score(score_to_add) -> void:
	var new_score_to_add = score_to_add * curr_multiplier
	score += new_score_to_add
	hud.update_score(score)
	game_over.update_score(score)
	

func game_init() -> void:
	super.game_init()

func game_start() -> void:
	super.game_start()

func game_pause() -> void:
	super.game_pause()

func game_exit() -> void:
	super.game_exit()

func _on_player_player_take_damage(curr_health) -> void:
	print("Updating GUI")
	hud.update_player_health(curr_health)

func _on_player_died() -> void:
	print("Player died")
	combo_timer.stop()
	_on_combo_timeout()
	lives -= 1
	hud.update_lives(lives)
	if lives <= 0:
		print("Game Over")
		game_over.show_game_over()
	else:
		_spawn_player()


func _on_game_over_restart_game() -> void:
	game_over.hide()
	_update_score(0)
	enemies_killed = 0
	_update_multiplier()
	lives = 3
	hud.update_lives(lives)
	%EnemySpawner.clear_enemies()
	_spawn_player()

func _on_game_over_quit_game() -> void:
	pass
