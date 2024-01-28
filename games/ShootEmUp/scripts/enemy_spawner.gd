extends Node

@onready var spawn_positions = $SpawnPositions
var enemy = preload("res://games/ShootEmUp/enemy.tscn")
var enemy_sprite: Texture2D
var enemy_death_sound: AudioStreamWAV

var curr_enemies = []

func _ready():
	var enemy_instantiation = enemy.instantiate()
	var enemy_sprites = enemy_instantiation.enemy_sprites
	var enemy_death_sounds = enemy_instantiation.death_sounds
	enemy_sprite = enemy_sprites.pick_random()
	enemy_death_sound = enemy_death_sounds.pick_random()
	_spawn_enemies()
	
func _spawn_enemies():
	var num_enemies = randi_range(6, 18)
	var positions = $SpawnPositions
	var pos_children = positions.get_children()
	
	pos_children.shuffle()
	var selected_positions = pos_children.slice(0, num_enemies - 1)
	for spawn_pos in pos_children:
		var this_enemy = enemy.instantiate()
		this_enemy.enemy_sprite = enemy_sprite
		this_enemy.death_audio = enemy_death_sound
		this_enemy.global_position = spawn_pos.global_position
		add_child(this_enemy)
		
