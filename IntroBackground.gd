extends ParallaxBackground

@onready var background = $ParallaxLayer/Sprite2D

func _process(delta):
	background.region_rect.position += delta * Vector2(50,50)
