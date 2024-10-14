# Setup for simple flat terrain
extends StaticBody2D

func _ready():
	# You can set up the size of the terrain in the editor or programmatically
	var collision_shape = $CollisionShape2D.shape
	collision_shape.extents = Vector2(1000, 10)  # This creates a long, flat platform
