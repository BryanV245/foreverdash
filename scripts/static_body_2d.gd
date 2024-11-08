extends StaticBody2D

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
