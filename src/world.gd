extends Node2D

@export
var world_size_in_chunks = 10

var TERRAIN_CHUNK_LENGTH: int = 256*16
const TERRAINS_SCENES: Array[PackedScene] = [
	preload("res://src/stage/chunks/terrain_chunk_1.tscn"),
	preload("res://src/stage/chunks/terrain_chunk_relaxed.tscn"),
	preload("res://src/stage/chunks/terrain_chunk_shelf.tscn"),
]
const TERRAIN_EXIT: PackedScene = preload("res://src/stage/chunks/terrain_chunk_exit.tscn")

var last_terrain_position: int = 0

func _process(_delta: float) -> void:
	if $Wheel.position.x > last_terrain_position:
		var terrain
		if $Wheel.position.x > world_size_in_chunks*TERRAIN_CHUNK_LENGTH:
			terrain = TERRAIN_EXIT.instantiate()
		else:
			terrain = TERRAINS_SCENES[randi() % TERRAINS_SCENES.size()].instantiate()
		last_terrain_position += TERRAIN_CHUNK_LENGTH
		terrain.position = Vector2(last_terrain_position, 0)
		$Chunks.add_child(terrain)
		for terrain_chunk: Node2D in $Chunks.get_children():
			if $Wheel.position.x - terrain_chunk.position.x >  2*TERRAIN_CHUNK_LENGTH:
				terrain_chunk.queue_free()
