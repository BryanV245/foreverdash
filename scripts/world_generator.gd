extends Node2D

# Load the platform scene 
var platform_scene = preload("res://scenes/platform.tscn")

# Variables for procedural generation
var min_platform_width = 200  # Minimum platform width
var max_platform_width = 1000  # Maximum platform width
var platform_height = 400      # Fixed height for the platforms
var noise_scale = 0.25          # Spread of the noise
var amplitude = 75           # Maximum height variation for platforms

# Reference to the player
@onready var player = $"/root/Game/Player"

# Noise generator using FastNoiseLite
var noise = FastNoiseLite.new()

# Store the generated platforms
var platforms = []

# How far the terrain has been generated
var generation_distance = 0

#How many platforms have been generated- used to calculate spike generation
var platform_count = 1

func _ready():

	#This is to debug collision shapes
	#get_tree().debug_collisions_hint = true;
	
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	
	# Initialize the noise generator with a random seed
	noise.seed = randi()
	
	# Generate some initial platforms when the game starts
	for i in range(0, 10):
		generate_next_platform()

func _process(delta):
	# Continuously generate platforms ahead of the player
	if player.position.x + 500 > generation_distance:
		generate_next_platform()

	# Clean up old platforms that are too far behind the player
	cleanup_old_platforms()

# Function to generate the next platform
# Store the Y position of the last generated platform
var last_platform_y = 300  # default value 

# Minimum vertical distance between platforms to avoid stacking
var min_vertical_spacing = 50  

func generate_next_platform():
	var x_position = generation_distance  # X position for the next platform

	# Use Simplex Noise to calculate Y position
	var y_position = noise.get_noise_2d(x_position * noise_scale, 0) * amplitude + 300

	# Randomize platform width
	var platform_width = randf_range(min_platform_width, max_platform_width)
	
	#centered x
	x_position += platform_width / 2.0
	

	# Instance a new platform (Platform root node)
	var platform_instance = platform_scene.instantiate()
	
	platform_instance.get_node("StaticBody2D/CollisionShape2D").shape = RectangleShape2D.new()

	# Set platform position (Platform node position)
	platform_instance.position = Vector2(x_position, y_position)

	# Access the StaticBody2D node from the platform_instance
	var static_body = platform_instance.get_node("StaticBody2D")

	# Call the set_platform_size function on the StaticBody2D node
	
	static_body.set_platform_size(platform_width, platform_height, platform_count)

	# Add the platform (root node) to the scene
	add_child(platform_instance)
	
	platform_count += 1
	

	# Store platform reference for later cleanup
	platforms.append(platform_instance)

	# Update the last platform Y position
	last_platform_y = y_position

	# Move generation distance forward based on the platform width
	generation_distance += platform_width + randf_range(20, 100)


# Function to remove platforms that are far behind the player
func cleanup_old_platforms():
	var platforms_to_remove = []
	for platform in platforms:
		if platform.position.x < player.position.x - max_platform_width * 2:
			platforms_to_remove.append(platform)
	
	for platform in platforms_to_remove:
		platforms.erase(platform)
		platform.queue_free()
		
		
