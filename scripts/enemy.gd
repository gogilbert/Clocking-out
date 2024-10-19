extends CharacterBody2D

var speed = 50

var chase = false

var player = null

func _physics_process(delta):
	if chase && Globalscript.enemy_chasing:
		global_position = global_position.move_toward(player.position, delta*speed)
		#global_position += (player.position - global_position)/speed

	elif Globalscript.enemy_chasing:
		# bring him back to 0,0 position
		position = position.move_toward(Vector2(0,0), delta*speed)
		# position += (Vector2(0,0) - position)/speed
		if position.x < 0.5 && position.y < 0.5:
			Globalscript.enemy_chasing = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	chase = true
	Globalscript.enemy_chasing = true
	speed = 50

func _on_area_2d_body_exited(body: Node2D) -> void:
	speed = 50
	chase = false
