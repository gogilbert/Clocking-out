extends CharacterBody2D

var speed = 100

var chase = false

var player = null

func _physics_process(delta):
	if Globalscript.currentState >= 4:
		$AnimatedSprite2D.visible = true
		$Death/CollisionShape2D.disabled = false
	
	if chase && Globalscript.enemy_chasing && Globalscript.currentState > 5:
		global_position = global_position.move_toward(player.position, delta*speed)

	elif Globalscript.enemy_chasing && Globalscript.currentState > 5:
		# bring him back to 0,0 position
		position = position.move_toward(Vector2(0,0), delta*speed)

		if position.x < 0.5 && position.y < 0.5:
			Globalscript.enemy_chasing = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	chase = true
	Globalscript.enemy_chasing = true
	speed = 165

func _on_area_2d_body_exited(body: Node2D) -> void:
	speed = 100
	chase = false

func _on_death_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
