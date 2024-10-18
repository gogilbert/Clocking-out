extends Area2D
class_name InteractionArea

@onready var player = get_tree().get_first_node_in_group("player")

# the pickup text
@export var action_name: String = "interact"

# callable that can be overriden by whatever implements this
var interact: Callable = func():
	pass


func _on_body_entered(body) -> void:
	# register this area in the interaction manager
	if body == player:
		InteractionManager.setInteract(self)


func _on_body_exited(body) -> void:
	if body == player:
		InteractionManager.removeInteract(self)
