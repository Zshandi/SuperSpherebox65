extends Game

var score:int = 0
var lives:int = 3

const ONE_UP_SCORE = 5000

# --- Export Arrays ---
# store the music that plays in the background
@export
var music_arr: Array[AudioStreamWAV] = []

# store the different sprites the player can be
@export
var player_sprite_arr: Array[Texture2D] = []

# store the different shooting sounds
@export
var player_shoot_audio_arr: Array[AudioStreamWAV] = []

# store the different enemy and player hurt sounds
@export
var hurt_audio_arr: Array[AudioStreamWAV] = []

# store the different sprites the enemy can be 
@export
var enemy_sprite_arr: Array[Texture2D] = []

# store the different death sounds the enemies can have
@export
var enemy_death_sounds: Array[AudioStreamWAV] = []

# store the different enemy shoot sounds
@export
var enemy_shoot_sounds: Array[AudioStreamWAV] = []

# the different types of background images
@export
var back_images: Array[Texture2D] = []

# the different types of foreground images
@export
var front_images: Array[Texture2D] = []

# grab nodes when ready
@onready var background_music = $BackgroundMusic
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $UI/HUD
@onready var player_spawn_position = %PlayerSpawnPosition
@onready var scrolling_background = %ScrollingBackground

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
	
	# set up the background music
	background_music.stream = music_arr.pick_random()
	background_music.play()
	
	# set up the backdrop
	scrolling_background.set_front_layer(
		front_images.pick_random(),
		Main.random_color_a()
	)
	scrolling_background.set_back_layer(
		back_images.pick_random(),
		Main.random_color_a()
	)
	
	# set up the enemy spawner
	enemy_spawner.connect("enemy_spawned", _on_enemy_spawned)
	enemy_spawner.enemy_death_sound = enemy_death_sounds.pick_random()
	enemy_spawner.enemy_shoot_sound = enemy_shoot_sounds.pick_random()
	enemy_spawner.enemy_sprite = enemy_sprite_arr.pick_random()
	enemy_spawner.enemy_modulation = Main.random_color()
	
	# set up the randomize enemy attributes and spawn the player
	player_sprite = player_sprite_arr.pick_random()
	player_shoot_audio = player_shoot_audio_arr.pick_random()
	player_hurt_audio = hurt_audio_arr.pick_random()
	player_death_audio = hurt_audio_arr.pick_random()
	player_color = Main.random_color()
	player_speed = randi_range(100,600)
	player_shoot_speed = randi_range(50,5000)
	_spawn_player()
	
	# setup the combo multiplier
	combo_timer.connect("timeout", _on_combo_timeout)
	_update_multiplier()
	
	# set up the HUD of the game
	hud.player_sprite = player_sprite
	hud.player_color = player_color
	hud.update_lives(lives)
	
func _spawn_player() -> void:
	var player_instance = player.instantiate()
	player_instance.global_position = player_spawn_position.global_position
	player_instance.player_take_damage.connect(_on_player_take_damage)
	player_instance.player_died.connect(_on_player_died)
	hud.update_player_health(player_instance.health)
	add_child(player_instance)
	player_instance.player_sprite.texture = player_sprite
	player_instance.player_sprite.modulate = player_color
	player_instance.speed = player_speed
	player_instance.movement_speed = player_shoot_speed
	player_instance.shoot_audio.stream = player_shoot_audio
	player_instance.hurt_audio.stream = player_hurt_audio
	player_instance.death_audio.stream = player_death_audio

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
	

func _on_player_take_damage(curr_health) -> void:
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

func _process(delta):
	pass

func _on_game_initialized():
	super._on_game_initialized()

func _on_game_paused():
	super._on_game_paused()

func _on_game_quit():
	super._on_game_quit()
