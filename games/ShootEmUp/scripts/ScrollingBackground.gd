extends ParallaxBackground

@onready var back_sprite = $BackLayer/Sprite2D
@onready var front_sprite = $FrontLayer/Sprite2D
@onready var scroll_speed_back = Vector2(10,10)
@onready var scroll_speed_front = Vector2(30,30)

func _process(delta):
	back_sprite.region_rect.position += delta * scroll_speed_back
	front_sprite.region_rect.position += delta * scroll_speed_front
