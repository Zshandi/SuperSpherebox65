extends RefCounted
class_name GameInstanceData

var game_name:String

var game_image:Texture2D

var game_scene:PackedScene

var random_seed:int

func get_new_random_generator() -> RandomNumberGenerator:
	var rand := RandomNumberGenerator.new()
	rand.seed = random_seed
	return rand
