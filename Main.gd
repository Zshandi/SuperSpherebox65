extends Node2D
class_name Main

const game_data_filename := "game_data.tres"
const games_path := "res://games/"

const user_env_variables:Array[String] = ["USERNAME", "USER", "COMPUTERNAME"]

static var player_name:String = ""

static var all_game_data:Array[GameData] = []

static var all_game_save_data:Dictionary = {}

## Represents the position of the currently selected game in the menu
static var current_position:Vector2i = Vector2i.ZERO :
	set(value):
		current_position = value
		current_game_data = get_game_instance_data_for(current_position)

## Instance data for the currently selected game in the menu
static var current_game_data:GameInstanceData

## Static reference to the GameSelect node
static var game_select:GameSelect
## Static reference to the GameLoader node
static var game_loader:GameLoader
## Static reference to the GameLoader node
static var pause_menu:PauseMenu

func _ready():
	game_select = $GameSelect
	game_loader = $GameLoader
	pause_menu = $PauseMenu

func _init():
	
	# Load save data, if available
	load_save_data()
	
	# Set the player name for the random seed, if not loaded
	if player_name == "":
		player_name = "Player"
		
		for env_var in user_env_variables:
			if OS.has_environment(env_var):
				player_name = OS.get_environment(env_var)
				break
		
		persist_save_data()
	
	print_debug("player_name: ", player_name)
	
	# Load all of the game data
	var dir := DirAccess.open(games_path)
	
	for subdir in dir.get_directories():
		dir.change_dir(games_path)
		dir.change_dir(subdir)
		if dir.file_exists(game_data_filename):
			var path_to_data := dir.get_current_dir() + "/" + game_data_filename
			var data:GameData = load(path_to_data)
			if data.include_in_menu:
				all_game_data.push_back(data)
	
	# Ensure current_game_data is set before GameSelect._ready is called
	current_game_data = get_game_instance_data_for(current_position)

func _process(delta):
	if game_loader.current_game != null:
		if Input.is_action_just_pressed("power"):
			$PauseMenu.toggle_pause()

static func move_selection(direction:Vector2i):
	current_position += direction

static func get_save_index_for(instance_data:GameInstanceData) -> String:
	var pos_string := str(instance_data.menu_position)
	var seed_string := str(instance_data.random_seed)
	var name_string := str(instance_data.game_name)
	return str(pos_string, ":", seed_string, ":", name_string)

static func get_current_save_index() -> String:
	return get_save_index_for(current_game_data)

static func save_current_game(save_data:Dictionary):
	all_game_save_data[get_current_save_index()] = save_data
	persist_save_data()

static func load_current_game() -> Dictionary:
	var current_index := get_current_save_index()
	if all_game_save_data.has(current_index):
		return all_game_save_data[current_index]
	else:
		# No data for the current game instance has been saved,
		#  so return an empty Dictionary
		return {}

static func persist_save_data() -> void:
	var save_dict := {}
	save_dict["all_game_save_data"] = all_game_save_data
	save_dict["player_name"] = player_name
	
	var save_file := FileAccess.open("user://save_data", FileAccess.WRITE)
	save_file.store_var(save_dict)
	save_file.close()

static func load_save_data() -> void:
	if !FileAccess.file_exists("user://save_data"):
		# If the game has not yet been saved, leave values as default
		return
	
	var save_file := FileAccess.open("user://save_data", FileAccess.READ)
	var save_dict:Dictionary = save_file.get_var()
	
	all_game_save_data = save_dict["all_game_save_data"]
	player_name = save_dict["player_name"]

static func get_seed_for(menu_pos:Vector2i) -> int:
	var seed_string := player_name + "-" + str(menu_pos.x) + "-" + str(menu_pos.y)
	return seed_string.hash()

static func get_game_instance_data_for(menu_pos:Vector2i) -> GameInstanceData:
	
	var seed:int = get_seed_for(menu_pos)
	
	var game_data_select_seed = seed + 12342
	var game_data_rng := RandomNumberGenerator.new()
	game_data_rng.seed = game_data_select_seed
	
	var game_data_at_pos:GameData = pick_random(all_game_data, game_data_rng)
	
	var data := game_data_at_pos.generate_instance_data(seed)
	
	data.menu_position = menu_pos
	
	return data

#--- Utility functions ---#

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
