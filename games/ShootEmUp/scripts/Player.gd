class_name Player
extends CharacterBody2D

signal player_take_damage(curr_health)
signal player_died

var health: int = 3
var is_invulnerable: bool = false
var is_dead: bool = false

@export
var player_sprite_arr: Array[Texture2D] = []

@export
var shoot_audio_arr: Array[AudioStreamWAV] = []

@export
var hurt_audio_arr: Array[AudioStreamWAV] = []

@onready var player_sprite = $Sprite2D

var speed: int = 300
var fire_speed: int = 20

var laser = preload("res://games/ShootEmUp/Laser.tscn")
@onready var laser_container = $LaserContainer
@onready var shoot_audio = $ShootAudio
@onready var invulnerable_timer = %InvulnerableTimer
@onready var animation_player = %AnimationPlayer
@onready var hurt_audio = %HurtAudio
@onready var death_audio = %DeathAudio

func _ready():
	invulnerable_timer.connect("timeout", _on_invulnerable_timeout)
	_set_invulnerable()
	

func _process(delta):
	if Input.is_action_just_pressed("six"):
		_fire_laser()
	
func _physics_process(delta):
	_check_for_movement(delta)
	_check_outside()
	
func _set_invulnerable():
	is_invulnerable = true
	print("Player is invulnerable")
	invulnerable_timer.start()
	animation_player.set_assigned_animation("invulnerable")
	animation_player.play()

func _on_invulnerable_timeout():
	is_invulnerable = false
	print("Player is no longer invulnerable")
	
func take_damage():
	if not is_invulnerable:
		health -= 1
		emit_signal("player_take_damage", health)
		if health <= 0:
			die()
		else:
			_set_invulnerable()
			_hurt_animation()
			hurt_audio.play()

func _hurt_animation():
	animation_player.set_assigned_animation("damage")
	animation_player.play()

func die():
	if not is_dead:
		is_dead = true
		hide()
		death_audio.play()
		await get_tree().create_timer(2).timeout
		emit_signal("player_died")
		queue_free()

func _check_for_movement(delta):
	velocity = Vector2(0,0)
	# move left
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	elif Input.is_action_pressed("right"):
		velocity.x += speed
	move_and_slide()
	
	
func _check_outside():
	var viewport = get_viewport_rect()
	if global_position.x > viewport.size.x:
		global_position.x = viewport.size.x
	elif global_position.x < 0:
		global_position.x = 0
		
func _fire_laser():
	if not is_dead:
		var laser_instantiation = laser.instantiate()
		laser_instantiation.fire_speed = fire_speed
		laser_instantiation.global_position = global_position
		laser_instantiation.global_position.y -= 100
		laser_container.add_child(laser_instantiation)
		shoot_audio.play()
