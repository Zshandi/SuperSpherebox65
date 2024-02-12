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

func _post_draw_card_image(parent_control:Control, instance_date:GameInstanceData) -> void:
	instance_date.game_image_2 = eight_ball_images.pick_random()
	
	var sprite := draw_texture_random(instance_date.game_image_2, parent_control)
	sprite.modulate = instance_date.game_image_color_2
	
	if randf() < rotation_chance:
		sprite.rotation = randf_range(0, TAU)
	
	if randf() < scale_chance:
		sprite.scale = Vector2.ONE * randf_range(min_scale, max_scale)
