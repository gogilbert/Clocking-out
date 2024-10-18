extends Node

var current_scene = "storeFloor"
var from_scene = "";
var transition_scene = false

func changeScene():
	if transition_scene == true:
		transition_scene = false
		match current_scene:
			"storeFloor":
				current_scene = "back_room"
			"back_room":
				match from_scene:
					"doorL", "doorR":
						current_scene = "storeFloor"
					"stairs":
						current_scene = "break_room"
			"break_room":
				current_scene = "back_room"
