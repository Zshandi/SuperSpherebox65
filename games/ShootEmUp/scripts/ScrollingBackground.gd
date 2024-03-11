extends ParallaxBackground

@onready var back_sprite = $BackLayer/Sprite2D
@onready var front_sprite = $FrontLayer/Sprite2D
var scroll_speed_back
var scroll_speed_front

func _ready():	
	# randomize the scroll speed
	var back_speed = randi_range(0,100)
	var front_speed = randi_range(back_speed, 200)
	scroll_speed_back = Vector2(
		back_speed * (1 if randi() % 2 == 0 else -1),
		back_speed * (1 if randi() % 2 == 0 else -1)
		)
	scroll_speed_front = Vector2(front_speed, front_speed)

func set_back_layer(texture:Texture2D, modulate: Color) -> void:
	back_sprite.texture = texture
	back_sprite.modulate = modulate
	
func set_front_layer(texture:Texture2D, modulate: Color) -> void:
	front_sprite.texture = texture
	front_sprite.modulate = modulate

func _process(delta):
	back_sprite.region_rect.position += delta * scroll_speed_back
	front_sprite.region_rect.position += delta * scroll_speed_front
