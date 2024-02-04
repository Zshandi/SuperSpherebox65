extends Area2D

@export
var enemy_sprites: Array[Texture2D] = []
@export
var death_sounds: Array[AudioStreamWAV] = []

@onready var enemy_sprite = $Sprite2D
@onready var explosion = $ExplosionParticles
@onready var death_audio = $DeathAudio

@onready var laser = preload("res://games/ShootEmUp/EnemyLaser.tscn")
@onready var laserContainer = %LaserContainer
@onready var shootAudio = %ShootAudio

signal enemy_died(score)

var is_dead: bool = false
var shoot_timer: Timer


func _ready():
	explosion.emitting = false
	shoot_timer = Timer.new()
	shoot_timer.connect("timeout",  _on_shoot_timer_timeout)
	add_child(shoot_timer)
	_set_shoot_timer()

func _set_shoot_timer():
	shoot_timer.start(randf_range(0,2))

func _on_shoot_timer_timeout():
	var enemy_laser = laser.instantiate()
	enemy_laser.global_position = global_position
	laserContainer.add_child(enemy_laser)
	_set_shoot_timer()

func _on_area_entered(area):
	if not is_dead:
		area.queue_free()
		die()

func die():
	is_dead = true
	emit_signal("enemy_died", 100)
	explosion.emitting = true
	var pitch_variance = randf_range(0,1.5)
	death_audio.set_pitch_scale(death_audio.get_pitch_scale() + pitch_variance)
	death_audio.play()
	enemy_sprite.hide()
	await get_tree().create_timer(.5).timeout
	explosion.emitting = false
	await get_tree().create_timer(.5).timeout
	queue_free()
	
	
