extends Camera2D

var shake_strength: float = 0.0

var shake_decay = DEFAULT_SHAKE_DECAY

const DEFAULT_SHAKE_DECAY: float = 5.0
const DEFAULT_SHAKE_STRENGTH: float = 30.0

func shake_screen(strength: float = DEFAULT_SHAKE_STRENGTH, decay: float = DEFAULT_SHAKE_DECAY) -> void:
	shake_strengh = strength
	shake_decay = decay
	
func _process(delta):	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0 , shake_decay * delta)
		shake_strength = max(shake_strength, 0)
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO
