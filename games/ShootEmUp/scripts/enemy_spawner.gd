extends Node

@onready var spawn_positions = $SpawnPositions
@onready var curr_enemies = $CurrEnemies
var enemy = preload("res://games/ShootEmUp/enemy.tscn")
var enemy_sprite: Texture2D
var enemy_modulation
var enemy_death_sound: AudioStreamWAV

signal enemy_spawned(enemy)

func _ready():
	var enemy_instantiation = enemy.instantiate()
	var enemy_sprites = enemy_instantiation.enemy_sprites
	var enemy_death_sounds = enemy_instantiation.death_sounds
	enemy_sprite = enemy_sprites.pick_random()
	enemy_modulation = Color(randf(), randf(), randf(), 1)
	enemy_death_sound = enemy_death_sounds.pick_random()
	
func _process(delta):
	if len(curr_enemies.get_children()) == 0:
		print("Spawning enemies")
		_spawn_enemies()
	
func _spawn_enemies():
	var num_enemies = randi_range(3, 10)
	var positions = $SpawnPositions
	var pos_children = positions.get_children()
	
	pos_children.shuffle()
	var selected_positions = pos_children.slice(0, num_enemies - 1)
	for spawn_pos in selected_positions:
		var this_enemy = enemy.instantiate()
		curr_enemies.add_child(this_enemy)
		this_enemy.enemy_sprite.texture = enemy_sprite
		this_enemy.enemy_sprite.modulate = enemy_modulation
		this_enemy.death_audio.stream = enemy_death_sound
		this_enemy.global_position = spawn_pos.global_position
		emit_signal("enemy_spawned", this_enemy)
		