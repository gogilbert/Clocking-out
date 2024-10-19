extends Node2D

@export var item: InvItem
@onready var player = get_tree().get_first_node_in_group("player")
@export var interaction: InteractionArea

func _ready():
	interaction.interact = Callable(self, "_on_interact_item")

func _on_interact_item():
	player.collect(item)
	await get_tree().create_timer(0.5).timeout
	self.queue_free()
