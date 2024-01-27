extends Node2D

var player_name := ""

func get_seed_for(menu_pos:Vector2i) -> int:
	var seed_string := player_name + "-" + str(menu_pos.x) + "-" + str(menu_pos.y)
	return seed_string.hash()

func get_game_instance_data_for(menu_pos:Vector2i):
	var seed:int = get_seed_for(menu_pos)
	
	var game_data_index := menu_pos.x + menu_pos.y
	var game_data_at_pos := $GameData.get_child(game_data_index)
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
