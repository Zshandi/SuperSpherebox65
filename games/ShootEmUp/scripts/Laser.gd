extends Area2D

var fire_speed: int = 20

func _process(delta):
	_move_forward()
	
func _move_forward():
	global_position.y -= fire_speed
