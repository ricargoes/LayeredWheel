extends CenterContainer


func _ready() -> void:
	%StartGame.grab_focus()

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://src/world.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
