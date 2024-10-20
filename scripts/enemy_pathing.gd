extends PathFollow2D

var speed = 0.01

func _process(delta):
	if !Globalscript.enemy_chasing && Globalscript.currentState >  5:
		progress_ratio += delta * speed
		Globalscript.enemy_prevPosition = position
