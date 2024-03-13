extends Camera2D

var shake_strength: float = 0.0

const SHAKE_DURATION: float = 5.0
const DEFAULT_SCREEN_SHAKE: float = 30.0

func shake_screen(strength: int = 0) -> void:
	if strength == 0:
		shake_strength = DEFAULT_SCREEN_SHAKE
	else:
		shake_strength = strength
	
func _process(delta):	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0 , SHAKE_DURATION * delta)
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
