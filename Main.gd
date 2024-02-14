extends Node2D
class_name Main

const game_data_filename := "game_data.tres"
const games_path := "res://games/"

const user_env_variables:Array[String] = ["USERNAME", "USER", "COMPUTERNAME"]

var player_name := ""

var all_game_data:Array[GameData] = []

func get_seed_for(menu_pos:Vector2i) -> int:
	var seed_string := player_name + "-" + str(menu_pos.x) + "-" + str(menu_pos.y)
	return seed_string.hash()

func get_game_instance_data_for(menu_pos:Vector2i) -> GameInstanceData:
	
	var seed:int = get_seed_for(menu_pos)
	
	var game_data_select_seed = seed + 12342
	var game_data_rng := RandomNumberGenerator.new()
	game_data_rng.seed = game_data_select_seed
	
	var game_data_at_pos:GameData = pick_random(all_game_data, game_data_rng)
	
	var data := game_data_at_pos.generate_instance_data(seed)
	
	return data

func _init():
	player_name = "Player"
	
	for env_var in user_env_variables:
		if OS.has_environment(env_var):
			player_name = OS.get_environment(env_var)
			break
	
	print_debug("player_name: ", player_name)
	
	var dir := DirAccess.open(games_path)
	
	for subdir in dir.get_directories():
		dir.change_dir(games_path)
		dir.change_dir(subdir)
		if dir.file_exists(game_data_filename):
			var path_to_data := dir.get_current_dir() + "/" + game_data_filename
			var data:GameData = load(path_to_data)
			if data.include_in_menu:
				all_game_data.push_back(data)

func _process(delta):
	if $GameLoader.current_game != null:
		if Input.is_action_just_pressed("power"):
			$CanvasLayer/PauseMenu.toggle_pause()
			#$PauseMenu.toggle_pause()

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
