extends Node2D

@onready var door1: InteractionArea = $Door1Interact

func _ready():
	door1.interact = Callable(self, "_on_interact")

func _on_interact():
	await print("hi")
