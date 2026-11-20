extends Area2D

@export
var connected_actuator: Node2D

func _on_body_entered(body: Wheel) -> void:
	if connected_actuator and body.outer_layer == GameLibrary.Element.Electricity:
		connected_actuator.switch()
