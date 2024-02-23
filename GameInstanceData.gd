extends RefCounted
class_name GameInstanceData

# These values shouldn't be changed after creation

var game_name:String

var game_image:Texture2D
var game_image_2:Texture2D
var game_image_color:Color
var game_image_color_2:Color

var game_scene:PackedScene

var random_seed:int

var owning_game_data:GameData

func draw_card_image(parent_control:Control) -> void:
	owning_game_data.draw_card_image(parent_control, self)

func _init(owner:GameData):
	owning_game_data = owner
