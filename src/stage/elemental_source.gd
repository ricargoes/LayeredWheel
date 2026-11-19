class_name ElementalSource extends Area2D

@export
var type: GameLibrary.Element = GameLibrary.Element.Water

func _ready() -> void:
	match type:
		GameLibrary.Element.Water:
			$AnimatedSprite2D.animation = "water"
		GameLibrary.Element.Oil:
			$AnimatedSprite2D.animation = "oil"
		GameLibrary.Element.Gravel:
			$AnimatedSprite2D.animation = "gravel"
		GameLibrary.Element.Fire:
			$AnimatedSprite2D.animation = "flame"
		GameLibrary.Element.Electricity:
			$AnimatedSprite2D.animation = "cable"


func _on_body_entered(body: Node2D) -> void:
	body.get_splashed(type)
	$AnimatedSprite2D.play()
