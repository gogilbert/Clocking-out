extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.as_text_keycode() == "Enter":
			get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
