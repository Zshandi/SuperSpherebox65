extends Camera2D

var shake_strength: float = 0.0

const SHAKE_DURATION: float = 5.0
const DEFAULT_SCREEN_SHAKE: float = 20.0

func shake_screen() -> void:
	shake_strength = DEFAULT_SCREEN_SHAKE
	
func _process(delta):	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0 , SHAKE_DURATION * delta)
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
