extends TextureRect

var full_point_texture = preload("res://icon.svg")
var empty_point_texture = null

func lose_point() -> void:
	texture = empty_point_texture

func get_point() -> void:
	texture = full_point_texture
