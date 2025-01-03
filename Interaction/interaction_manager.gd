extends Node2D

# Gets scene label
@onready var label = $Label

const base_text = "[E] to "

var active_interact: InteractionArea = null
var can_interact = true

func setInteract(interact: InteractionArea):
	active_interact = interact

@warning_ignore("unused_parameter")
func removeInteract(interact: InteractionArea):
	if active_interact:
		active_interact = null

func _process(_delta):
	#If there is an active interact, update the label
	if active_interact != null && can_interact:
		label.text = base_text + active_interact.action_name
		label.global_position = active_interact.global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact && active_interact:
		can_interact = false
		label.hide()
		
		# call the implemented function
		await active_interact.interact.call()
		
		can_interact = true
