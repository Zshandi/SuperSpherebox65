extends Node2D
class_name GameSelect

@onready
var main:Main = $".."

@onready
var game_loader:GameLoader = $"../GameLoader"

var current_position:Vector2i = Vector2i.ZERO

var current_game_data:GameInstanceData

func _ready():
	sync_game_info()

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		move_selection(Vector2i.RIGHT)
	if Input.is_action_just_pressed("ui_down"):
		move_selection(Vector2i.DOWN)
	if Input.is_action_just_pressed("ui_left"):
		move_selection(Vector2i.LEFT)
	if Input.is_action_just_pressed("ui_up"):
		move_selection(Vector2i.UP)
	
	if Input.is_action_just_pressed("ui_accept"):
		play_current_selection()

func _on_button_right_pressed():
	move_selection(Vector2i.RIGHT)
func _on_button_down_pressed():
	move_selection(Vector2i.DOWN)
func _on_button_left_pressed():
	move_selection(Vector2i.LEFT)
func _on_button_up_pressed():
	move_selection(Vector2i.UP)

func _on_button_select_pressed():
	play_current_selection()

func move_selection(direction:Vector2i):
	current_position += direction
	sync_game_info()

func sync_game_info():
	current_game_data = main.get_game_instance_data_for(current_position)
	$GameSelectWindow/GameName.text = current_game_data.game_name
	$GameSelectWindow/Sprite2D.texture = current_game_data.game_image

func play_current_selection():
	game_loader.load_game(current_game_data)
	hide()
