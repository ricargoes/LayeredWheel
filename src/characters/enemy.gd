extends Area2D


@export
var does_fly: bool = false
@export
var base_flying_speed: float = 30

var flying_speed: float

func _ready() -> void:
	flying_speed = (0.8 + 0.4*randf())*base_flying_speed

func _on_body_entered(body: Wheel) -> void:
	if body.outer_layer == GameLibrary.Element.Fire:
		die()
	elif body.outer_layer == GameLibrary.Element.Electricity:
		body.shorten_active_layer_lifespan()
		die()
	else:
		body.hurt()

func _physics_process(delta: float) -> void:
	if does_fly:
		position.x -= flying_speed*delta

func die() -> void:
	queue_free()
