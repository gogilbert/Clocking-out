extends CharacterBody2D

# Modify this value to change the speed of the character
const speed = 175

enum dirs {LEFT, RIGHT, UP, DOWN}

var facingDir = dirs.DOWN

@export var inv: Inv

func _ready():
	$AnimatedSprite2D.play("down_idle")

func _physics_process(delta: float):
	player_movement(delta)

func setAnim(action: int):
	var animNode = $AnimatedSprite2D
	
	match action:
		0:
			match facingDir:
				dirs.LEFT:
					animNode.flip_h = true
					animNode.play("side_idle")
				dirs.RIGHT:
					animNode.flip_h = false
					animNode.play("side_idle")
				dirs.UP:
					animNode.play("up_idle")
				dirs.DOWN:
					animNode.play("down_idle")
		1:
			match facingDir:
				dirs.LEFT:
					animNode.flip_h = true
					animNode.play("walk_side")
				dirs.RIGHT:
					animNode.flip_h = false
					animNode.play("walk_side")
				dirs.UP:
					animNode.play("walk_up")
				dirs.DOWN:
					animNode.play("walk_down")

func player_movement(delta: float):
	
	# Determines the movement action of the player
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
		
		# Setting up the variables so the right animation is selected
		facingDir = dirs.RIGHT
		setAnim(1);
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0

		# Setting up the variables so the right animation is selected
		facingDir = dirs.LEFT
		setAnim(1);

	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -speed

		# Setting up the variables so the right animation is selected
		facingDir = dirs.UP
		setAnim(1);

	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = speed
		
		# Setting up the variables so the right animation is selected
		facingDir = dirs.DOWN
		setAnim(1);

	else:
		velocity.x = 0
		velocity.y = 0
		setAnim(0);

	# Moves the player based off of the new velocity values you've set
	move_and_slide()

func collect(item):
	inv.insert(item)
