extends CanvasLayer

var life_point_scene: PackedScene = preload("res://src/ui/life_point.tscn")

func initialize(max_life_points: int, points: int) -> void:
	for i in range(max_life_points):
		var lifepoint_object = life_point_scene.instantiate()
		%Health.add_child(lifepoint_object)
	
	sync_points(points)

func sync_life(life_points, max_life_points) -> void:
	var lifepoints_objects = %Health.get_children()
	for i in range(life_points):
		lifepoints_objects[i].get_point()
	for i in range(life_points, max_life_points):
		lifepoints_objects[i].lose_point()

func sync_points(points: int) -> void:
	%Score.text = str(points)
