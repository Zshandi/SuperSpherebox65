extends Laser
	
func _move_forward(delta):
	global_position.y += fire_speed * delta



func _on_body_entered(body):
	if (body is Player):
		body.take_damage()
		queue_free()
