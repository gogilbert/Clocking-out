extends PathFollow2D

var speed = 0.03

func _ready() -> void:
	progress_ratio = Globalscript.enemy_prevPosition

func _process(delta):
	if !Globalscript.enemy_chasing && Globalscript.currentState >  5:
		progress_ratio += delta * speed
		Globalscript.enemy_prevPosition = progress_ratio
		$Enemy.get_node("AnimatedSprite2D").play("moving")
