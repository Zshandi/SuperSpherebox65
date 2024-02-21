extends Laser
	
func _move_forward(delta: int) -> void:
	global_position.y += fire_speed * delta



func _on_body_entered(body) -> void:
	if (body is Player):
		body.take_damage()
		queue_free()
