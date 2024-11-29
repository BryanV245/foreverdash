extends Node2D
var SPEED = 40
var direction = 1
var platform_width = 0
var left_edge = 0
var right_edge = 0

@onready var raycast_left: RayCast2D = $raycast_left
@onready var raycast_right: RayCast2D = $raycast_right

var width = 12

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(raycast_right.is_colliding() || reach_right()):
		direction = -1
	else:
		if(raycast_left.is_colliding() || reach_left()):
			direction = 1
	position.x += direction * SPEED * delta
	
	
#check to see if the spike has hit the left end of the platform
func reach_left():
	if(position.x <= left_edge):
		return true
	else: 
		return false

#check to see if the spike has hit the right end of the platform
func reach_right():
	if(position.x >= right_edge): 
		return true
	else:
		return false
		
func getWidth():
	return width
	
#function to set the left and right ends of the platform
func set_plat(plat_width: int):
	left_edge = (plat_width/2) * -1
	right_edge = (plat_width/2) - width
