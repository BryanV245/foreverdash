extends CharacterBody2D

const SPEED = 300
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if position.y > 1000 || position.y < -1000:
		position.y = -100
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimationPlayer.play("jump")
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RESET")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY


	# Always move to the right at a constant speed.
	velocity.x = SPEED 

	# Move the character using move_and_slide().
	move_and_slide()
