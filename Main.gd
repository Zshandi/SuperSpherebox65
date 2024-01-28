extends Node2D
class_name Main

var player_name := ""

var loaded_instance_data:Dictionary = {}

func get_seed_for(menu_pos:Vector2i) -> int:
	var seed_string := player_name + "-" + str(menu_pos.x) + "-" + str(menu_pos.y)
	return seed_string.hash()

func get_game_instance_data_for(menu_pos:Vector2i) -> GameInstanceData:
	if loaded_instance_data.has(menu_pos):
		return loaded_instance_data[menu_pos]
	
	var seed:int = get_seed_for(menu_pos)
	
	var game_data_select_seed = seed + 12342
	var game_data_rng := RandomNumberGenerator.new()
	game_data_rng.seed = game_data_select_seed
	var game_data_index := game_data_rng.randi_range(0, $GameData.get_child_count()-1)
	
	var game_data_at_pos:GameData = $GameData.get_child(game_data_index)
	
	var data := game_data_at_pos.generate_instance_data(seed)
	
	loaded_instance_data[menu_pos] = data
	return data

func _ready():
	if OS.has_environment("USERNAME"):
		player_name = OS.get_environment("USERNAME")
	elif OS.has_environment("USER"):
		player_name = OS.get_environment("USER")
	elif OS.has_environment("COMPUTERNAME"):
		player_name = OS.get_environment("COMPUTERNAME")
	else:
		player_name = "Player"
	
	print_debug("player_name: ", player_name)


static func get_random_index(array:Array, random_generator:RandomNumberGenerator) -> int:
	return random_generator.randi_range(0, array.size()-1)

static func pick_random(array:Array, random_generator:RandomNumberGenerator):
	if array.size() == 0:
		return null
	var index = get_random_index(array, random_generator)
	return array[index]

static func random_color() -> Color:
	return Color(randf(), randf(), randf(), 1)

static func random_color_a() -> Color:
	return Color(randf(), randf(), randf(), randf())
