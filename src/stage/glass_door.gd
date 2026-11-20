extends Area2D


func _on_body_entered(body: Wheel) -> void:
	if body.outer_layer != GameLibrary.Element.Gravel:
		body.hurt()
	shatter()

func shatter() -> void:
	queue_free()
