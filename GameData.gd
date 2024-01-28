extends Node
class_name GameData

# Game Global values

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
var game_scene:PackedScene

func get_random_index(random_generator:RandomNumberGenerator, array:Array) -> int:
	return random_generator.randi_range(0, array.size()-1)

func generate_instance_data(random_seed:int) -> GameInstanceData:
	var random_generator := RandomNumberGenerator.new()
	random_generator.seed = random_seed
	
	var name1_index := get_random_index(random_generator, possible_names_1)
	var name2_index := get_random_index(random_generator, possible_names_2)
	var sequel_index := get_random_index(random_generator, possible_name_sequels)
	
	var name1 := possible_names_1[name1_index]
	var name2 := possible_names_2[name2_index]
	var sequel := possible_name_sequels[sequel_index]
	
	var is_sequel := random_generator.randf() <= name_sequel_chance
	var is_swapped := random_generator.randf() <= name_swap_chance
	
	var game_name := ""
	if is_swapped:
		game_name = name2 + " " + name1
	else:
		game_name = name1 + " " + name2
	
	if is_sequel:
		game_name += " " + sequel
	
	var image_index := get_random_index(random_generator, possible_game_images)
	var image:Texture2D
	if possible_game_images.size() > 0:
		image = possible_game_images[image_index]
	
	var game_instance := GameInstanceData.new()
	
	game_instance.game_name = game_name
	game_instance.game_image = image
	game_instance.random_seed = random_seed
	game_instance.game_scene = game_scene
	
	return game_instance
