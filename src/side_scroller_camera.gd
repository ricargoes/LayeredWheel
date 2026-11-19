extends Camera2D

@export
var followee: Node2D

func _ready() -> void:
	var window_size = get_viewport().get_visible_rect().size
	offset = Vector2(0.4*window_size.x, 0.5*window_size.y)

func _physics_process(_delta: float) -> void:
	global_position.x = followee.global_position.x
