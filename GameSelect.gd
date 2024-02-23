extends Node2D
class_name GameSelect

@onready
var move_sound:AudioStreamPlayer = $"../Sounds/move"

#var current_position:Vector2i = Vector2i.ZERO
#
#var current_game_data:GameInstanceData

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
	
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("power"):
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
	Main.move_selection(direction)
	sync_game_info()

func sync_game_info():
	$GameSelectWindow/GameName.text = Main.current_game_data.game_name
	
	var sprite_container:Control = $GameSelectWindow/SpriteContainer
	
	for child in sprite_container.get_children():
		child.queue_free()
	
	Main.current_game_data.draw_card_image(sprite_container)

func play_current_selection():
	Main.game_loader.load_game(Main.current_game_data)
	close_menu()

func close_menu():
	hide()
	menu_music.stop()
	$"../ScrollingBackground".hide()
	process_mode = Node.PROCESS_MODE_DISABLED

func open_menu():
	show()
	menu_music.play()
	$"../ScrollingBackground".show()
	process_mode = Node.PROCESS_MODE_INHERIT
