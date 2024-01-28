extends Node2D


@onready var controller = $ControllerSprite
@onready var fade_out = $FadeOut

func _ready():
	fade_out.hide()
	await get_tree().create_timer(1.5).timeout
	print("Starting animation")
	var tween = create_tween()
	tween.tween_property(
		controller, 
		"position", 
		Vector2(
			controller.global_position.x,
			controller.global_position.y - 600
		),
		1
	)
	await get_tree().create_timer(2.5).timeout
	fade_out.show()
	tween = create_tween()
	tween.tween_property(
		fade_out,
		"color",
		Color(1,1,1,1),
		1
	)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://main.tscn")
	
