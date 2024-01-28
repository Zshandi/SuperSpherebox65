extends ParallaxBackground

@export
var back_images: Array[Texture2D] = []
@export
var front_images: Array[Texture2D] = []


@onready var back_sprite = $BackLayer/Sprite2D
@onready var front_sprite = $FrontLayer/Sprite2D
var scroll_speed_back
var scroll_speed_front

func _ready():
	# choose the front and back images
	back_sprite.texture = back_images.pick_random()
	front_sprite.texture = front_images.pick_random()
	
	# modulate the colors
	back_sprite.modulate = Main.random_color_a()
	front_sprite.modulate = Main.random_color_a()
	
	# randomize the scroll speed
	var back_speed = randi_range(0,100)
	var front_speed = randi_range(back_speed, 200)
	scroll_speed_back = Vector2(
		back_speed * (1 if randi() % 2 == 0 else -1),
		back_speed * (1 if randi() % 2 == 0 else -1)
		)
	scroll_speed_front = Vector2(front_speed, front_speed)
	


func _process(delta):
	back_sprite.region_rect.position += delta * scroll_speed_back
	front_sprite.region_rect.position += delta * scroll_speed_front
