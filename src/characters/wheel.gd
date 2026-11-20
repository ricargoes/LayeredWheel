class_name Wheel extends CharacterBody2D

const JUMP_FORCE = 10000
const MAX_JUMP_IMPULSE_TIME: float = 0.2

@export
var player_speed: int = 500

@export
var max_life_points: int = 3

var outer_layer: GameLibrary.Element = GameLibrary.Element.Air
var inner_layer: GameLibrary.Element = GameLibrary.Element.Air
var life_points: float = 50.0
var enemies_slain: int = 0

var jump_impulse_time: float = 0.0

signal died

func _ready() -> void:
	life_points = max_life_points
	#$UI.sync_life(life_points, max_life_points)

func _process(delta: float) -> void:
	velocity.x = player_speed
	if is_on_floor():
		$Anim.animation = "run"
		jump_impulse_time = MAX_JUMP_IMPULSE_TIME
	else:
		$Anim.animation = "jump"
		jump_impulse_time -= delta
		velocity.y += delta*GameLibrary.GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and Input.is_action_pressed("down"):
		position.y += 5
		jump_impulse_time = 0
	elif Input.is_action_pressed("jump") and jump_impulse_time > 0:
		velocity.y -= delta*JUMP_FORCE
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("change_layer"):
		change_layer()

func change_layer() -> void:
	if outer_layer in GameLibrary.active_elements():
		return
	var buffer = outer_layer
	outer_layer = inner_layer
	inner_layer = buffer

func get_splashed(element: GameLibrary.Element) -> void:
	match element:
		GameLibrary.Element.Water:
			match outer_layer:
				GameLibrary.Element.Air, GameLibrary.Element.Water:
					imbue_layer(GameLibrary.Element.Water)
				GameLibrary.Element.Oil:
					imbue_layer(GameLibrary.Element.Oil)
				GameLibrary.Element.Gravel:
					imbue_layer(GameLibrary.Element.Mud)
				GameLibrary.Element.Fire:
					imbue_layer(GameLibrary.Element.Air)
				GameLibrary.Element.Electricity, GameLibrary.Element.Mud:
					shorten_active_layer_lifespan()
		GameLibrary.Element.Oil:
			match outer_layer:
				GameLibrary.Element.Air, GameLibrary.Element.Oil:
					imbue_layer(GameLibrary.Element.Oil)
				GameLibrary.Element.Water, GameLibrary.Element.Gravel, GameLibrary.Element.Electricity, GameLibrary.Element.Mud:
					pass
				GameLibrary.Element.Fire:
					lengthen_active_layer_lifespan()
		GameLibrary.Element.Gravel:
			match outer_layer:
				GameLibrary.Element.Air, GameLibrary.Element.Gravel, GameLibrary.Element.Fire:
					imbue_layer(GameLibrary.Element.Gravel)
				GameLibrary.Element.Water, GameLibrary.Element.Electricity:
					imbue_layer(GameLibrary.Element.Mud)
				GameLibrary.Element.Oil:
					pass
				GameLibrary.Element.Mud:
					shorten_active_layer_lifespan()
		GameLibrary.Element.Fire:
			match outer_layer:
				GameLibrary.Element.Air, GameLibrary.Element.Gravel, GameLibrary.Element.Fire:
					hurt()
				GameLibrary.Element.Water, GameLibrary.Element.Electricity:
					imbue_layer(GameLibrary.Element.Air)
				GameLibrary.Element.Oil:
					imbue_layer(GameLibrary.Element.Fire)
				GameLibrary.Element.Mud:
					pass
		GameLibrary.Element.Electricity:
			match outer_layer:
				GameLibrary.Element.Air, GameLibrary.Element.Gravel, GameLibrary.Element.Oil, GameLibrary.Element.Fire:
					hurt()
				GameLibrary.Element.Water:
					imbue_layer(GameLibrary.Element.Electricity)
				GameLibrary.Element.Electricity:
					lengthen_active_layer_lifespan()
				GameLibrary.Element.Mud:
					pass

func shorten_active_layer_lifespan() -> void:
	$ActiveLayerLifespan.time_left /= 2 


func lengthen_active_layer_lifespan() -> void:
	$ActiveLayerLifespan.time_left *= 1.5

func imbue_layer(element: GameLibrary.Element) -> void:
	outer_layer = element
	if element in GameLibrary.active_elements():
		$ActiveLayerLifespan.start(10)
	else:
		$ActiveLayerLifespan.stop()

func hurt(damage: int = 1):
	life_points -= damage
	#$UI.sync_life(life_points, max_life_points)
	if life_points <= 0:
		die()

func die():
	died.emit()
