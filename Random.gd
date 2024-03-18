extends RefCounted
class_name Random

@warning_ignore("shadowed_global_identifier")
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
	return i() % (to - from) + from

func f() -> float:
	# TODO: Calculate f() from i(), so that all that needs implemented
	#         in the random algorithm is the i method
	return _internal_rng.randf()

func f_range(from:float, to:float) -> float:
	return f() * (to - from) + from

func pick(from:Array) -> Variant:
	if from == null || from.is_empty():
		return null
	var index = i_range(0, from.size())
	return from[index]

func color(min_alpha:float = 1) -> Color:
	return Color(f(), f(), f(), f_range(min_alpha, 1))

func color_alpha() -> Color:
	return color(0)

var _internal_rng:RandomNumberGenerator

func _init(should_randomize:bool = false):
	_internal_rng = RandomNumberGenerator.new()
	if should_randomize:
		self.randomize()
