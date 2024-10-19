extends Node2D

@export var mute: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func play_door() -> void:
	if not mute:
		$DoorSFX.play()
