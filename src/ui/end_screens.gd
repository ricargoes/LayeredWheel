extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause()

func pause() -> void:
	get_tree().paused = true
	%Text.hide()
	%Retry.hide()
	%Resume.show()
	show()
	%Resume.grab_focus()

func defeat(points: int) -> void:
	get_tree().paused = true
	%Text.text = "Your escape did not succeed and you are back in the lab.\nLet's try again!\n\nYour score is: %s" % points
	%Text.show()
	%Retry.show()
	%Resume.hide()
	show()
	%Retry.grab_focus()
	
func victory(points: int) -> void:
	get_tree().paused = true
	%Text.text = "You managed to escape from the lab.\nHooray!!!\n\nYour score is: %s" % points
	%Text.show()
	%Retry.show()
	%Resume.hide()
	show()
	%Retry.grab_focus()

func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/ui/main_menu.tscn")

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
