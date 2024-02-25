extends MarginContainer

@onready var life_icon = $TextureRect


func _ready():
	life_icon.set_scale(Vector2(0.5,0.5))
