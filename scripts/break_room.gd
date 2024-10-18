extends Node2D

@onready var stairs: InteractionArea = $StairsInteract

func _process(delta):
	change_scene()

func _ready():
	stairs.interact = Callable(self, "_on_interact_stairs")

	#Chooses where to spawn player based on what scene they come from
	match Globalscript.from_scene:
		"stairs":
			$Player.position.x = 321
			$Player.position.y = 153

	
func _on_interact_stairs():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "stairs"

func change_scene():
	if Globalscript.transition_scene == true:
		if Globalscript.current_scene == "break_room":
			get_tree().change_scene_to_file("res://scenes/back_room.tscn")
			Globalscript.changeScene()
