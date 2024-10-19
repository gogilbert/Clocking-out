extends Node2D

@onready var stairs: InteractionArea = $StairsInteract
@onready var SleepInteract: InteractionArea = $SleepInteract

const introLines: Array[String] = [
	"Ah, only 20 minutes till my bus arrives",
	"Maybe I'll put my head down and rest for a bit"
]

const wakeUpLines: Array[String] = [
	"Wait, what time is it!",
	"11:30?!?! I gotta get home!"
]

func _process(delta):
	if Globalscript.currentState == 0:
		DialogManager.start_dialog($Player.position, introLines)
		Globalscript.currentState = 1
		$SleepInteract/CollisionShape2D.disabled = false
	change_scene()

func _ready():
	stairs.interact = Callable(self, "_on_interact_stairs")
	SleepInteract.interact = Callable(self, "_on_interact_sleep")
	
	#Chooses where to spawn player based on what scene they come from
	match Globalscript.from_scene:
		"stairs":
			$Player.position.x = 321
			$Player.position.y = 153

func _on_interact_sleep():
	$StairsInteract/CollisionShape2D.disabled = false
	$SleepInteract/CollisionShape2D.disabled = true
	$DarkerTint.color = Color(0, 0, 0, 1)
	await get_tree().create_timer(2).timeout
	$DarkerTint.color = Color(0, 0, 0, 0.59)
	Globalscript.currentState = 2
	
	await get_tree().create_timer(1).timeout
	DialogManager.start_dialog($Player.position, wakeUpLines)
	
func _on_interact_stairs():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "stairs"


func change_scene():
	if Globalscript.transition_scene == true:
		if Globalscript.current_scene == "break_room":
			get_tree().change_scene_to_file("res://scenes/back_room.tscn")
			Globalscript.changeScene()
