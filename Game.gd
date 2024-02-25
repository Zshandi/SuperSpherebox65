extends Node2D
class_name Game

var has_won:bool = false
var high_score:int = 0

## Tells the game system to exit to the menu
signal quit_game()

## Tells the game system to reload the current game
signal restart_game()

## Tells the game system to persist the given save_data to disk
## Note that this overwrites any previous save data for the current instance
## Will be loaded on next game start by calling load_save_data
signal save_game(save_data:Dictionary)

## Instance data used for the game selection menu
var game_instance_data:GameInstanceData

## Called after the game has all values set by GameLoader,
##  but before the Game is added to the scene tree.
## If the game must be in the scene tree, use _ready instead
func _on_game_initialized():
	seed(game_instance_data.random_seed)

## Called to load the given save data, after initialization
func _load_save_data(save_data:Dictionary):
	pass

## Called when the game is paused
func _on_game_paused():
	pass

## Called when the game is quit, just before being freed
func _on_game_quit():
	pass
