class_name Player
extends CharacterBody2D

signal player_take_damage(curr_health)
signal player_died

var health: float = 3
var is_invulnerable: bool = false
var is_dead: bool = false

@onready var player_sprite = $Sprite2D

var speed: int = 300
var movement_speed: int = 20

var laser = preload("res://games/ShootEmUp/player_laser.tscn")
@onready var laser_container = $LaserContainer
@onready var shoot_audio = $ShootAudio
@onready var animation_player = %AnimationPlayer
@onready var hurt_audio = %HurtAudio
@onready var death_audio = %DeathAudio
#var death_audio_source: AudioStreamWAV

func _ready():
	_set_invulnerable()
	

func _process(delta):
	if Input.is_action_just_pressed("six"):
		_fire_laser()
	
func _physics_process(delta):
	_check_for_movement(delta)
	_check_outside()
	
func _set_invulnerable() -> void:
	is_invulnerable = true
	print("Player is invulnerable")
	animation_player.set_assigned_animation("invulnerable")
	animation_player.play()
	await animation_player.animation_finished
	is_invulnerable = false
	
func take_damage(damage_amount: float = 1) -> void:
	if not is_invulnerable:
		health -= damage_amount
		player_take_damage.emit(health)
		if health <= 0:
			die()
		else:
			_set_invulnerable()
			_hurt_animation()
			hurt_audio.play()

func _hurt_animation() -> void:
	animation_player.set_assigned_animation("damage")
	animation_player.play()

func die() -> void:
	if not is_dead:
		is_dead = true
		hide()
		death_audio.play()
		process_mode = Node.PROCESS_MODE_DISABLED
		await get_tree().create_timer(2).timeout
		player_died.emit()
		queue_free()

func _check_for_movement(delta: float) -> void:
	velocity = Vector2(0,0)
	# move left
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	elif Input.is_action_pressed("right"):
		velocity.x += speed
	move_and_slide()
	
	
func _check_outside() -> void:
	var viewport = get_viewport_rect()
	if global_position.x > viewport.size.x:
		global_position.x = viewport.size.x
	elif global_position.x < 0:
		global_position.x = 0
		
func _fire_laser() -> void:
	var laser_instantiation = laser.instantiate()
	laser_instantiation.movement_speed = movement_speed
	laser_instantiation.global_position = global_position
	laser_instantiation.global_position.y -= 100
	laser_container.add_child(laser_instantiation)
	shoot_audio.play()
