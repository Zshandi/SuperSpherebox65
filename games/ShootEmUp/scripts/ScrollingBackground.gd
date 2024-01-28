extends ParallaxBackground

@export
var back_images: Array[Texture2D] = []
@export
var front_images: Array[Texture2D] = []


@onready var back_sprite = $BackLayer/Sprite2D
@onready var front_sprite = $FrontLayer/Sprite2D
@onready var scroll_speed_back = Vector2(10,10)
@onready var scroll_speed_front = Vector2(30,30)

func _ready():
	# choose the front and back images
	back_sprite.texture = back_images.pick_random()
	front_sprite.texture = front_images.pick_random()
	
	# modulate the colors
	back_sprite.modulate = Color(randf(), randf(), randf(), randf())
	front_sprite.modulate = Color(randf(), randf(), randf(), randf())


func _process(delta):
	back_sprite.region_rect.position += delta * scroll_speed_back
	front_sprite.region_rect.position += delta * scroll_speed_front
