class_name Laser
extends Area2D

enum FiringStyle {
	STRAIGHT, WAVY
}

var firing_style = FiringStyle.STRAIGHT
var movement_speed: int = 200
const LIFESPAN = 5

func _ready():
	pass
	#var visible_on_screen_notifier = VisibleOnScreenEnabler2D()

func _process(delta):
	_move(delta)
	
func _move(delta: float) -> void:
	global_position.y -= movement_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("Exiting screen")
	queue_free()
