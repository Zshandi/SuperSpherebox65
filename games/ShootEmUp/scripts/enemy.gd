extends Area2D

@export
var enemy_sprites: Array[Texture2D] = []

@export
var death_sounds: Array[AudioStreamWAV] = []

@onready var enemy_sprite = $Sprite2D
@onready var explosion = $ExplosionParticles
@onready var death_audio = $DeathAudio

func _ready():
	enemy_sprite.texture = enemy_sprites.pick_random()
	enemy_sprite.modulate = Color(randf(), randf(), randf(), 1)
	explosion.emitting = false
	death_audio.stream = death_sounds.pick_random()


func _on_area_entered(area):
	area.queue_free()
	die()

func die():
	explosion.emitting = true 
	death_audio.play()
	enemy_sprite.hide()
	await get_tree().create_timer(.5).timeout
	explosion.emitting = false
	await get_tree().create_timer(3).timeout
	queue_free()
	
	
