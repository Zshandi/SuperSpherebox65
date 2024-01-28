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
	
	var game_data_index := menu_pos.x + menu_pos.y
	game_data_index %= $GameData.get_child_count()
	
	var game_data_at_pos:GameData = $GameData.get_child(game_data_index)
	
	var data := game_data_at_pos.generate_instance_data(seed)
	
	loaded_instance_data[menu_pos] = data
	return data

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
