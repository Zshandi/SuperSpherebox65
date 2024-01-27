extends Node2D
class_name GameSelect

@onready
var game_loader:GameLoader = $"../GameLoader"

var current_selection:Game

func _ready():
	var scene := preload("res://game_1.tscn").instantiate()
	game_loader.load_game(scene)
