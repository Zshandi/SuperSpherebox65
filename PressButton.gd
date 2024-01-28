extends Label

var is_flashing = false

func _process(delta):
	if not is_flashing:
		_flash()
		
	if Input.is_action_just_pressed("six"):
		get_tree().change_scene_to_file("res://main.tscn")
		
func _flash():
	is_flashing = true
	hide()
	await get_tree().create_timer(.5).timeout
	show()
	await get_tree().create_timer(.5).timeout
	is_flashing = false
