class_name Laser
extends Area2D

enum FiringStyle {
	STRAIGHT, WAVY
}

var firing_style = FiringStyle.STRAIGHT
var fire_speed: int = 20

func _process(delta):
	_move_forward(delta)
	
func _move_forward(delta):
	global_position.y -= fire_speed * delta
