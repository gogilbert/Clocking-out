extends Node2D

@onready var stairs: InteractionArea = $StairsInteract
@onready var SleepInteract: InteractionArea = $SleepInteract
@onready var KeyPosterInteract: InteractionArea = $KeyPoster

const introLines: Array[String] = [
	"Ah, only 20 minutes till my bus arrives",
	"Maybe I'll put my head down and rest for a bit"
]

const wakeUpLines: Array[String] = [
	"Wait, what time is it!",
	"11:30?!?! I gotta get home!"
]

const keyPosterLines: Array[String] = [
	"What is this poster on the floor?",
	"\"I HATE working here! The manager keeps stealing our emergency exit keys.\"",
	"\"I once had to figure out how to make a key using items in the store!\"",
	"\"All I needed was a plate, a boxcutter, glue, and a pack of ramen.\"",
	"\"I know this makes no sense, but I jammed it all into the keyhole and it f***ing opened!\"",
	"Hmmm, desperate times call for desperate measures. I might as well try it..." 
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
	KeyPosterInteract.interact = Callable(self, "_on_interact_keyposter")
	
	if Globalscript.currentState > 5:
		$StairsInteract/CollisionShape2D.disabled = false
		$SleepInteract/CollisionShape2D.disabled = true
		$KeyPoster/CollisionShape2D.disabled = false
		$KeyPoster/Sprite2D.visible = true
		
		$DarkerTint.color = Color(0, 0, 0, 0.59)
	
	#Chooses where to spawn player based on what scene they come from
	match Globalscript.from_scene:
		"stairs":
			$Player.position.x = 321
			$Player.position.y = 153

func _on_interact_sleep():
	$StairsInteract/CollisionShape2D.disabled = false
	$SleepInteract/CollisionShape2D.disabled = true
	$DarkerTint.color = Color(0, 0, 0, 1)
	DialogManager.start_dialog($Player.position, wakeUpLines)
	await get_tree().create_timer(2).timeout
	$DarkerTint.color = Color(0, 0, 0, 0.59)
	Globalscript.currentState = 2
	
func _on_interact_stairs():
	Globalscript.transition_scene = true
	Globalscript.from_scene = "stairs"

func _on_interact_keyposter():
	DialogManager.start_dialog($Player.position, keyPosterLines)
	Globalscript.currentState = 7
	

func change_scene():
	if Globalscript.transition_scene == true:
		if Globalscript.current_scene == "break_room":
			get_tree().change_scene_to_file("res://scenes/back_room.tscn")
			Globalscript.changeScene()
