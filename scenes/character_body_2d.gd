#extends CharacterBody2D
#
#var speed = 200  # Speed of movement
#var gravity = 500  # Gravity pulling the player down
#var jump_velocity = -300  # How high the player jumps
#
#func _physics_process(delta):
	## Apply gravity to the player
	#velocity.y += gravity * delta
#
	## Move left and right based on input
	#if Input.is_action_pressed("ui_right"):
		#velocity.x = speed
	#elif Input.is_action_pressed("ui_left"):
		#velocity.x = -speed
	#else:
		#velocity.x = 0
#
	## Jump if the player is on the ground and the up arrow is pressed
	#if Input.is_action_just_pressed("ui_up") and is_on_floor():
		#velocity.y = jump_velocity
		#gravity *= -1;
#
	## Move the player using move_and_slide with the built-in velocity
	#move_and_slide()


extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		gravity *= -1;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
