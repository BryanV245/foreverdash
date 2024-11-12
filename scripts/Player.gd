extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -300.0
var jumpCount = 2
var active
@onready var collision_shape = $CollisionShape2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	
	setActive(true)  #initiates active
	velocity.x = SPEED

func _physics_process(delta):
		
	if not active:
		get_tree().change_scene_to_file("res://scenes/control.tscn")
		return
	
	if position.y > 1000 || position.y < -1000:
		position.y = -100
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimationPlayer.play("jump")
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RESET")
		jumpCount = 2  #reset double jump
		pass

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") && jumpCount > 0:
		velocity.y = JUMP_VELOCITY
		jumpCount -= 1  #decrement double jump
	
	# Always move to the right at a constant speed.
	velocity.x = SPEED
	# Move the character using move_and_slide().
	move_and_slide()
	
func setActive(value: bool):
	active = value
	
func die():
	setActive(false)
	collision_shape.set_deferred("disabled", true)
	
	
	### ---- FOR TESTING PURPOSES -----
	
#extends CharacterBody2D
#
#
#const SPEED = 300.0
#const JUMP_VELOCITY = -250.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY 
#
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
