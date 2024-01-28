extends Area2D

@export
var enemy_sprites: Array[Texture2D] = []
@export
var death_sounds: Array[AudioStreamWAV] = []

@onready var enemy_sprite = $Sprite2D
@onready var explosion = $ExplosionParticles
@onready var death_audio = $DeathAudio

signal enemy_died(score)

var is_dead: bool = false

func _ready():
	explosion.emitting = false


func _on_area_entered(area):
	if not is_dead:
		area.queue_free()
		die()

func die():
	is_dead = true
	emit_signal("enemy_died", 100)
	explosion.emitting = true 
	death_audio.play()
	enemy_sprite.hide()
	await get_tree().create_timer(.5).timeout
	explosion.emitting = false
	await get_tree().create_timer(.5).timeout
	queue_free()
	
	
