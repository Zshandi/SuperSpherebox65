extends ParallaxBackground

@export
var background: Texture2D

@onready var sprite = $ParallaxLayer/Sprite2D

@onready var background_sprite = $ParallaxLayer/Sprite2D
@onready var color_rect = $ParallaxLayer2/ColorRect

func _ready():
	sprite.texture = background
	

func _process(delta):
	background_sprite.region_rect.position += delta * Vector2(50,50)
