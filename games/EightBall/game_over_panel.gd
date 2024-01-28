extends Control

@onready var fortune = $Panel/fortune

func set_fortune(fortune_to_set):
	fortune.text = fortune_to_set
