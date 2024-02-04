extends CharacterBody2D

var health: int = 3

@export
var player_sprite_arr: Array[Texture2D] = []

@export
var shoot_audio_arr: Array[AudioStreamWAV] = []

@onready var player_sprite = $Sprite2D

var speed: int = 300
var fire_speed: int = 20

var laser = preload("res://games/ShootEmUp/Laser.tscn")
@onready var laser_container = $LaserContainer


@onready var shoot_audio = $ShootAudio

func _ready():
	player_sprite.texture = player_sprite_arr.pick_random()
	player_sprite.modulate = Main.random_color()
	speed = randi_range(100,600)
	fire_speed = randi_range(50,5000)
	shoot_audio.stream = shoot_audio_arr.pick_random()

func _process(delta):
	if Input.is_action_just_pressed("six"):
		_fire_laser()
	
func _physics_process(delta):
	_check_for_movement(delta)
	_check_outside()

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
	var laser_instantiation = laser.instantiate()
	laser_instantiation.fire_speed = fire_speed
	laser_instantiation.global_position = global_position
	laser_instantiation.global_position.y -= 100
	laser_container.add_child(laser_instantiation)
	shoot_audio.play()
