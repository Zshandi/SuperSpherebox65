extends Resource
class_name WeirdFortune

@export
## The weight of chance to get this fortune relative to the other weird fortunes
var fortune_chance_weight:float = 1

@export
## The minimum and maximum number of fortunes before this fortune appears
var num_fortune_min_max:Vector2i = Vector2i(10, 50)

@export
## The sequence of fortunes to display when it's time to display this fortune
var fortune_sequence:Array[String] = [""]
