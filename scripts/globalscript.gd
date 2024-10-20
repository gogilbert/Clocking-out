extends Node

var current_scene = "break_room"
var from_scene = "";
var transition_scene = false

var enemy_chasing = false
var enemy_prevPosition = 0

var hiding = false

var currentState = 0

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
