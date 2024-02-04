extends Laser
	
func _move_forward(delta):
	global_position.y += fire_speed * delta
