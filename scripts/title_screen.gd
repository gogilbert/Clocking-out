extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.as_text_keycode() == "Enter":
			get_tree().change_scene_to_file("res://scenes/break_room.tscn")

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
