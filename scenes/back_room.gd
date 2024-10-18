extends Node2D

@onready var doorL: InteractionArea = $DoorLInteract
@onready var doorR: InteractionArea = $DoorRInteract
@onready var stairs: InteractionArea = $StairsInteract

func _process(delta):
	change_scene()

func _ready():
	doorL.interact = Callable(self, "_on_interact_doorL")
	doorR.interact = Callable(self, "_on_interact_doorR")
	stairs.interact = Callable(self, "_on_interact_stairs")

	#Chooses where to spawn player based on what scene they come from
	match Globalscript.from_scene:
		"doorL":
			$Player.position.x = 318
			$Player.position.y = 184
		"doorR":
			$Player.position.x = 769
			$Player.position.y = 184

func _on_interact_doorL():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "doorL"

func _on_interact_doorR():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "doorR"
	
func _on_interact_stairs():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "stairs"

func change_scene():
	if Globalscript.transition_scene == true:
		if Globalscript.current_scene == "back_room":
			get_tree().change_scene_to_file("res://scenes/storeFloor.tscn")
			Globalscript.changeScene()
