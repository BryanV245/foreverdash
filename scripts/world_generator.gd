extends Node2D

# Load the platform scene 
var platform_scene = preload("res://scenes/platform.tscn")
var single_spike_scene = preload("res://scenes/obstacles/spikes_single.tscn")
var double_spike_scene = preload("res://scenes/obstacles/spikes_double.tscn")
var triple_spike_scene = preload("res://scenes/obstacles/spikes_tripple.tscn")
var quadruple_spike_scene = preload("res://scenes/obstacles/spikes_quadruple.tscn")

# Variables for procedural generation
var min_platform_width = 200  # Minimum platform width
var max_platform_width = 1000  # Maximum platform width
var platform_height = 400      # Fixed height for the platforms
var noise_scale = 0.25          # Spread of the noise
var amplitude = 100           # Maximum height variation for platforms

# Reference to the player
@onready var player = $"/root/Game/Player"

# Noise generator using FastNoiseLite
var noise = FastNoiseLite.new()

#random number generator
var rng = RandomNumberGenerator.new()

# Store the generated platforms
var platforms = []

# How far the terrain has been generated
var generation_distance = 0

#How many platforms have been generated- used to calculate spike generation
var platform_count = 0

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
	
	var left_x = x_position
	
	#centered x
	x_position += platform_width / 2.0
	

	# Instance a new platform (Platform root node)
	var platform_instance = platform_scene.instantiate()
	
	platform_instance.get_node("StaticBody2D/CollisionShape2D").shape = RectangleShape2D.new()

	# Set platform position (Platform node position)
	platform_instance.position = Vector2(x_position, y_position)
	print(x_position, " + ", y_position)

	# Access the StaticBody2D node from the platform_instance
	var static_body = platform_instance.get_node("StaticBody2D")

	# Call the set_platform_size function on the StaticBody2D node
	static_body.set_platform_size(platform_width, platform_height)

	# Add the platform (root node) to the scene
	add_child(platform_instance)
	
	platform_count += 1
	
	generate_spike_row(x_position, y_position, platform_width, platform_height, calcSpikeRow(platform_count))

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
		
		
func calcSpikeRow(platformCount: float):
	if platformCount >= 1 && platformCount < 2  :
		return 1
	else:
		if platformCount >= 2 && platformCount < 3:
			return 2
		else: 
			if platformCount >= 3 && platformCount < 4:
				return 3
			else:
				if platformCount >= 4:
					return 4
					
	
	

func generate_spike_row(x_position: float, y_position: float, width: float, height: float, spike_count: int):
	# Choose the correct spike scene based on spike_count
	var spike_row_scene
	match spike_count:
		1:
			spike_row_scene = single_spike_scene
		2:
			spike_row_scene = double_spike_scene
		3:
			spike_row_scene = triple_spike_scene
		4:
			spike_row_scene = quadruple_spike_scene
		_:
			
			print("Invalid spike count! Defaulting to single spike.")
			spike_row_scene = single_spike_scene # Fallback to single spike if invalid count
			# Instantiate the chosen spike row scene
	var spike_row_instance = spike_row_scene.instantiate()
	
	var left = x_position - width/2
	print("Left", left)
	var right = x_position + width/2
	print("right", right)
	print("y", y_position)
	var surface = y_position + height/2 * -1
	print("surface", surface)
	var offset = randi_range(left, x_position + width/2 - spike_row_instance.getWidth())
	print("offset", offset)
	
	print("width", width)
	print("height", height)
	
	# Position the spike row
	spike_row_instance.position = Vector2(left + offset, surface)
	
	# Add the spike row instance to the current scene
	add_child(spike_row_instance)
