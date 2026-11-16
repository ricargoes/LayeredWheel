extends CharacterBody2D

const JUMP_FORCE = 9000
const MAX_JUMP_IMPULSE_TIME: float = 0.2

@export
var player_speed: int = 500

@export
var max_life_points: int = 3

var outer_layer: String = "air"
var inner_layer: String = "air"
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
	var buffer = outer_layer
	outer_layer = inner_layer
	inner_layer = buffer
	
func hurt(damage: int = 1):
	life_points -= damage
	#$UI.sync_life(life_points, max_life_points)
	if life_points <= 0:
		die()

func die():
	died.emit()
