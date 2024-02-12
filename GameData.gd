extends Resource 
class_name GameData

# Game Global values

@export
var include_in_menu:bool = true

@export
var possible_names_1:Array[String] = []

@export
var possible_names_2:Array[String] = []

@export
var possible_name_sequels:Array[String] = ["2", "3", "13", "65", "42", "II", "III", "IV", "XI", "Plus", "Extra", "Deluxe"]

@export
var name_sequel_chance := 0.4

@export
var name_swap_chance := 0.4

@export
var possible_game_images:Array[Texture2D] = []
@export
var possible_game_images_2:Array[Texture2D] = []

@export
var game_scene:PackedScene

func _internal_generate_game_instance_data(game_instance:GameInstanceData) -> void:
	pass

func _create_new_instance_data() -> GameInstanceData:
	return GameInstanceData.new(self)

func _pre_draw_card_image(parent_control:Control, instance_date:GameInstanceData) -> void:
	pass

func _post_draw_card_image(parent_control:Control, instance_date:GameInstanceData) -> void:
	pass

func draw_texture(texture:Texture2D, on_control:Control,
		offset_percent:Vector2 = Vector2.ONE/2, scale:Vector2 = Vector2.ONE,
		rotation:float = 0) -> Sprite2D:
	
	var x_pos := offset_percent.x * on_control.size.x
	var y_pos := offset_percent.y * on_control.size.y
	
	var position := Vector2(x_pos, y_pos)
	
	var sprite := Sprite2D.new()
	
	sprite.texture = texture
	sprite.position = position
	sprite.scale = scale
	
	on_control.add_child(sprite)
	
	return sprite

func draw_texture_with_color(texture:Texture2D, on_control:Control, color:Color,
		offset_percent:Vector2 = Vector2.ONE/2, scale:Vector2 = Vector2.ONE,
		rotation:float = 0) -> Sprite2D:
	
	var sprite = draw_texture(texture, on_control, offset_percent, scale, rotation)
	
	if color != null:
		sprite.modulate = color
	
	return sprite


func draw_card_image(parent_control:Control, instance_data:GameInstanceData):
	_pre_draw_card_image(parent_control, instance_data)
	
	if instance_data.game_image != null:
		draw_texture_with_color(instance_data.game_image, parent_control, instance_data.game_image_color)
	
	if instance_data.game_image_2 != null:
		draw_texture_with_color(instance_data.game_image_2, parent_control, instance_data.game_image_color_2)
	
	_post_draw_card_image(parent_control, instance_data)

func generate_instance_data(random_seed:int) -> GameInstanceData:
	seed(random_seed)
	
	var name1 = possible_names_1.pick_random()
	var name2 = possible_names_2.pick_random()
	var sequel = possible_name_sequels.pick_random()
	
	var is_sequel := randf() <= name_sequel_chance
	var is_swapped := randf() <= name_swap_chance
	
	var game_name := ""
	if name1 != null && name2 != null:
		if is_swapped:
			game_name = name2 + " " + name1
		else:
			game_name = name1 + " " + name2
		
		if is_sequel && sequel != null:
			game_name += " " + sequel
	
	var image:Texture2D = possible_game_images.pick_random()
	var image_2:Texture2D = possible_game_images_2.pick_random()
	var image_color := Main.random_color()
	var image_color_2 := Main.random_color()
	
	var game_instance := _create_new_instance_data()
	
	game_instance.game_name = game_name
	
	game_instance.game_image = image
	game_instance.game_image_2 = image_2
	game_instance.game_image_color = image_color
	game_instance.game_image_color_2 = image_color_2
	
	game_instance.random_seed = random_seed
	game_instance.game_scene = game_scene
	
	_internal_generate_game_instance_data(game_instance)
	
	return game_instance
