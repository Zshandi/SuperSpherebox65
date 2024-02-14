extends GameData

@export
var eight_ball_images: Array[Texture2D] = []

@export_range(0,1)
var rotation_chance:float

@export_range(0,1)
var scale_chance:float

@export_range(0,10)
var min_scale:float = 1

@export_range(0,10)
var max_scale:float = 1

@export_range(0,1)
var multiple_chance:float

@export
var multiple_max:int = 4

func _post_draw_card_image(parent_control:Control, instance_date:GameInstanceData) -> void:
	instance_date.game_image_2 = eight_ball_images.pick_random()
	
	var num_sprites:int = 1
	if randf() < multiple_chance:
		num_sprites = randi_range(2, multiple_max)
	
	var scale := Vector2.ONE / sqrt(num_sprites)
	if randf() < scale_chance:
		scale *= randf_range(min_scale, max_scale)
	
	var rotate := randf() < rotation_chance
	
	for i in range(0, num_sprites):
		var sprite := draw_texture_random(instance_date.game_image_2, parent_control)
		sprite.modulate = instance_date.game_image_color_2
		
		if rotate:
			sprite.rotation = randf_range(0, TAU)
		
		sprite.scale = scale
