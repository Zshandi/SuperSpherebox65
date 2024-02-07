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

func get_random_index(random_generator:RandomNumberGenerator, array:Array) -> int:
	return random_generator.randi_range(0, array.size()-1)

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
	
	var game_instance := GameInstanceData.new()
	
	game_instance.game_name = game_name
	
	game_instance.game_image = image
	game_instance.game_image_2 = image_2
	game_instance.game_image_color = image_color
	game_instance.game_image_color_2 = image_color_2
	
	game_instance.random_seed = random_seed
	game_instance.game_scene = game_scene
	
	return game_instance
