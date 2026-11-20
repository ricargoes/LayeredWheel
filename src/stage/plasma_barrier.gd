extends Node2D


func switch() -> void:
	$Anim.animation = "off"
	set_deferred("monitoring", false)

func _on_body_entered(body: Wheel) -> void:
	body.hurt()
