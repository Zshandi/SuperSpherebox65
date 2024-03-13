extends Area2D

@export
var health: float = 1

@onready var enemy_sprite = $Sprite2D
@onready var explosion = $ExplosionParticles
@onready var death_audio = $DeathAudio

@onready var laser = preload("res://games/ShootEmUp/enemy_laser.tscn")
@onready var shoot_audio = %ShootAudio

signal enemy_died(score)

var is_dead: bool = false
var shoot_timer: Timer


func _ready():
	explosion.emitting = false
	shoot_timer = Timer.new()
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	add_child(shoot_timer)
	_set_shoot_timer()

func _set_shoot_timer():
	shoot_timer.start(randf_range(0,5))

func _on_shoot_timer_timeout():
	if not is_dead:
		var enemy_laser = laser.instantiate()
		enemy_laser.global_position = global_position
		get_node("../../EnemyLaserContainer").add_child(enemy_laser)
		shoot_audio.play()
		_set_shoot_timer()

func take_damage(damage_amount: float = 1) -> void:
	if not is_dead:
		health -= damage_amount
		var pitch_variance = randf_range(0,1.5)
		death_audio.set_pitch_scale(death_audio.get_pitch_scale() + pitch_variance)
		death_audio.play()
		if health <= 0:
			die()


func die() -> void:
	is_dead = true
	emit_signal("enemy_died", 100)
	process_mode = Node.PROCESS_MODE_DISABLED
	explosion.show()
	explosion.emitting = true
	enemy_sprite.hide()
	await get_tree().create_timer(.5).timeout
	explosion.emitting = false
	await get_tree().create_timer(.5).timeout
	queue_free()
	
	
