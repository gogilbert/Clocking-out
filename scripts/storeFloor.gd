extends Node2D

@onready var doorL: InteractionArea = $DoorLInteract
@onready var doorR: InteractionArea = $DoorRInteract
@onready var frontI: InteractionArea = $FrontInteract
@onready var hide1: InteractionArea = $HidingPlace1
@onready var hide2: InteractionArea = $HidingPlace2

const frontText: Array[String] = [
	"Oh no! The door is locked!"
]

const enemyText: Array[String] = [
	"Who's there?"
]

const escapeText: Array[String] = [
	"I gotta get out of here!",
	"Maybe I should hide in the break room..."
]

var recentHide = 0

func _ready():
	doorL.interact = Callable(self, "_on_interact_doorL")
	doorR.interact = Callable(self, "_on_interact_doorR")
	frontI.interact = Callable(self, "_on_interact_front")
	hide1.interact = Callable(self, "_on_interact_hide1")
	hide2.interact = Callable(self, "_on_interact_hide2")

	match Globalscript.from_scene:
		"doorL":
			$Player.position.x = 319
			$Player.position.y = 25
		"doorR":
			$Player.position.x = 772
			$Player.position.y = 25

	if Globalscript.currentState > 2:
		$FrontInteract/CollisionShape2D.disabled = true

	if Globalscript.currentState >= 7:
		$HidingPlace1/CollisionShape2D.disabled = false
		$HidingPlace2/CollisionShape2D.disabled = false

func _process(delta):
	change_scene()
	if !DialogManager.is_dialog_active && Globalscript.currentState == 3:
		Globalscript.currentState = 4
		$Player/Camera2D.offset = Vector2(-600, -50)
		DialogManager.start_dialog($EnemyPath/PathFollow2D/Enemy.global_position, enemyText)
	if !DialogManager.is_dialog_active && Globalscript.currentState == 4:
		Globalscript.currentState = 5
		$Player/Camera2D.offset = Vector2(0, 0)
		DialogManager.start_dialog($Player.position, escapeText)
	if !DialogManager.is_dialog_active && Globalscript.currentState == 5:
		Globalscript.currentState = 6
	if Globalscript.hiding == true && recentHide == 1:
		hide1.action_name = "show"
		InteractionManager.setInteract(hide1)
	if Globalscript.hiding == true && recentHide == 2:
		hide2.action_name = "show"
		InteractionManager.setInteract(hide2)

func _on_interact_hide1():
	if !Globalscript.hiding:
		Globalscript.hiding = true
		recentHide = 1
		$Player/AnimatedSprite2D.visible = false
		$Player/CollisionShape2D.disabled = true
	else:
		Globalscript.hiding = false
		hide1.action_name = "hide"
		$Player/AnimatedSprite2D.visible = true
		$Player/CollisionShape2D.disabled = false

func _on_interact_hide2():
	if !Globalscript.hiding:
		Globalscript.hiding = true
		recentHide = 2
		$Player/AnimatedSprite2D.visible = false
		$Player/CollisionShape2D.disabled = true
	else:
		Globalscript.hiding = false
		hide2.action_name = "hide"
		$Player/AnimatedSprite2D.visible = true
		$Player/CollisionShape2D.disabled = false

	
func _on_interact_front():
	$FrontInteract/CollisionShape2D.disabled = true
	Globalscript.currentState = 3
	DialogManager.start_dialog($Player.position, frontText)

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
