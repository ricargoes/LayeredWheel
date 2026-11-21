extends Area2D

@export
var value: int = 3

func _on_body_entered(body: Wheel) -> void:
	body.score(value)
	queue_free()
