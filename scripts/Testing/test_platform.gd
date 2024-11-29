extends StaticBody2D

var moving_spike_scene = preload("res://scenes/obstacles/moving_spikes_single.tscn")

var plat_width = 0
var plat_height = 0



# Function to adjust platform size (visual and collision)
func set_platform_size(width: float, height: float):
	
	plat_width = width
	plat_height = height
	
	# Ensure both Sprite2D and CollisionShape2D are positioned at the same origin
	$Sprite2D.position = Vector2(0, 0)
	$CollisionShape2D.position = Vector2(0, 0)

	# Adjust the Sprite2D visual size (scale it to match the new width)
	var sprite = $Sprite2D
	if sprite.texture:
		var original_width = sprite.texture.get_size().x
		var original_height = sprite.texture.get_size().y
		
		# Scale the sprite based on the desired width
		sprite.scale.x = width / original_width
		sprite.scale.y = height / original_height
		
	# Adjust the CollisionShape2D size to match the scaled sprite
	var collision_shape = $CollisionShape2D.shape
	if collision_shape is RectangleShape2D:
		# Update extents (half the size of the platform)
		collision_shape.extents = Vector2(width / 2, height / 2) 
		
		
	#spikes start at platform 15 to give the player the chance to get a feel for the game

	movingSpike(width, height)
		
		
func movingSpike(width: float, height: float):
	var spike_instance = moving_spike_scene.instantiate()
	print("instantiated moving spike")
	var offset = randi_range(0, width - spike_instance.getWidth())

	spike_instance.set_plat(width)

	print("offset: ", offset)
	spike_instance.position = Vector2((width / 2 * -1) + offset, height / 2 * -1)
	print("spike position: ", spike_instance.position) 
	add_child(spike_instance)
