extends Node2D

@onready var doorL: InteractionArea = $DoorLInteract
@onready var doorR: InteractionArea = $DoorRInteract

func _ready():
	doorL.interact = Callable(self, "_on_interact_doorL")
	doorR.interact = Callable(self, "_on_interact_doorR")

	match Globalscript.from_scene:
		"doorL":
			$Player.position.x = 319
			$Player.position.y = 25
		"doorR":
			$Player.position.x = 772
			$Player.position.y = 25

func _process(delta):
	change_scene()

func _on_interact_doorL():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "doorL"
	AudioController.play_door()

func _on_interact_doorR():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "doorR"
	AudioController.play_door()

func change_scene():
	if Globalscript.transition_scene == true:
		if Globalscript.current_scene == "storeFloor":
			get_tree().change_scene_to_file("res://scenes/back_room.tscn")
			Globalscript.changeScene()
