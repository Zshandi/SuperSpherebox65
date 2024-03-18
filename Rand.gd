class_name Rand

static var instance := Random.new(true)

@warning_ignore("shadowed_global_identifier")
static var seed:
	get: return instance.seed
	set(value): instance.seed = value

static var state:
	get: return instance.state
	set(value): instance.state = value

static func randomize():
	instance.randomize()

static func i() -> int:
	return instance.i()

static func i_range(from:int, to:int) -> int:
	return instance.i_range(from, to)

static func f() -> float:
	return instance.f()

static func f_range(from:float, to:float) -> float:
	return instance.f_range(from, to)

static func pick(from:Array) -> Variant:
	return instance.pick(from)

static func color(min_alpha:float = 1) -> Color:
	return instance.color(min_alpha)

static func color_alpha() -> Color:
	return instance.color_a()
