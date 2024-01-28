extends Node2D
class_name GameSelect

@onready
var main:Main = $".."

@onready
var game_loader:GameLoader = $"../GameLoader"

@onready
var move_sound:AudioStreamPlayer = $"../Sounds/move"

var current_position:Vector2i = Vector2i.ZERO

var current_game_data:GameInstanceData

@onready var menu_music: AudioStreamPlayer = $"../MenuMusic"

func _ready():
	sync_game_info()
	menu_music.play()

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
	move_sound.play()
	current_position += direction
	sync_game_info()
	

func sync_game_info():
	current_game_data = main.get_game_instance_data_for(current_position)
	$GameSelectWindow/GameName.text = current_game_data.game_name
	$GameSelectWindow/Sprite2D.texture = current_game_data.game_image
	$GameSelectWindow/Sprite2D.modulate = current_game_data.game_image_color
	$GameSelectWindow/Sprite2D2.texture = current_game_data.game_image_2
	$GameSelectWindow/Sprite2D2.modulate = current_game_data.game_image_color_2

func play_current_selection():
	game_loader.load_game(current_game_data)
	close_menu()
	menu_music.stop()

func close_menu():
	hide()
	$"../ScrollingBackground".hide()
	process_mode = Node.PROCESS_MODE_DISABLED

func open_menu():
	show()
	$"../ScrollingBackground".show()
	process_mode = Node.PROCESS_MODE_INHERIT


func _on_game_loader_start_menu_music():
	menu_music.play()
