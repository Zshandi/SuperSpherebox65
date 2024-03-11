extends RefCounted
class_name Random

var seed:
	get: return _internal_rng.seed
	set(value): _internal_rng.seed = value

var state:
	get: return _internal_rng.state
	set(value): _internal_rng.state = value

func randomize():
	_internal_rng.randomize()

func i() -> int:
	return _internal_rng.randi()

func i_range(from:int, to:int) -> int:
	return _internal_rng.randi_range(from, to)

func f() -> float:
	return _internal_rng.randf()

func f_range(from:float, to:float) -> float:
	return _internal_rng.randf_range(from, to)

func pick(from:Array):
	if from == null || from.is_empty():
		return null
	var index = i_range(0, from.size())
	return from[index]

func color(min_alpha:float = 1):
	return color_a(min_alpha)

func color_a(min_alpha:float = 0):
	return Color(f(), f(), f(), f_range(min_alpha, 1))

var _internal_rng:RandomNumberGenerator

func _init(randomize:bool = false):
	_internal_rng = RandomNumberGenerator.new()
	if randomize:
		randomize()
