class_name Laser
extends Area2D

enum FiringStyle {
	STRAIGHT, WAVY
}

@export
var firing_direction: Vector2 = Vector2(0,-1)

@export
var damage_amount: float = 1

var firing_style = FiringStyle.STRAIGHT
var movement_speed: int = 200
const LIFESPAN = 5

func _ready():
	pass
	#var visible_on_screen_notifier = VisibleOnScreenEnabler2D()

func _process(delta):
	_move(delta)
	
func _move(delta: float) -> void:
	global_position += firing_direction * movement_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	_damage_object_entered(body)
		
func _on_area_entered(area):
	_damage_object_entered(area)
	
func _damage_object_entered(object) -> void:
	if object.has_method("take_damage"):
		object.take_damage(damage_amount)
	await get_tree().create_timer(.05).timeout
	queue_free()
