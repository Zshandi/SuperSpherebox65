class_name Laser
extends Area2D

enum FiringStyle {
	STRAIGHT, WAVY
}

var firing_style = FiringStyle.STRAIGHT
var fire_speed: int = 200
const LIFESPAN = 5

func _ready():
	var lifespan_timer = Timer.new()
	lifespan_timer.connect("timeout", _on_lifespan_timeout)
	add_child(lifespan_timer)
	lifespan_timer.start(LIFESPAN)

func _on_lifespan_timeout() -> void:
	queue_free()

func _process(delta) -> void:
	_move_forward(delta)
	
func _move_forward(delta) -> void:
	global_position.y -= fire_speed * delta
