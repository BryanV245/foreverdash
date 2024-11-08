extends Node2D


# Called when the node enters the scene tree for the first time.
# Load the platform scene 
var platform_scene = preload("res://scenes/Testing/test_platform.tscn")

#Load the spike scenes
var single_spike_scene = preload("res://scenes/obstacles/spikes_single.tscn")
var double_spike_scene = preload("res://scenes/obstacles/spikes_double.tscn")
var triple_spike_scene = preload("res://scenes/obstacles/spikes_tripple.tscn")
var quadruple_spike_scene = preload("res://scenes/obstacles/spikes_quadruple.tscn")


var platform_width = 500
var platform_height = 100

#random number generator
var rng = RandomNumberGenerator.new()


@onready var player = $"/root/test/Player"

func _ready():

	generate_platform();
	#generate_spike(0,0);

	#This is to debug collision shapes
	get_tree().debug_collisions_hint = true;

func generate_platform():
	
	var platform_instance = platform_scene.instantiate()
	
	platform_instance.get_node("StaticBody2D/CollisionShape2D").shape = RectangleShape2D.new()

	# Set platform position (Platform node position)
	platform_instance.position = Vector2(0, 0)

	var static_body = platform_instance.get_node("StaticBody2D")
	
	static_body.set_platform_size(platform_width, platform_height)

	# Add the platform (root node) to the scene
	add_child(platform_instance)
	
	#for n in fmod(platform_width, 8):
		#generate_spike(platform_width, platform_height, randi_range(0, platform_width))
	
	#print(static_body.get_platform_width()) #---- Debuggin ----
	#print(static_body.get_platform_height()) #---- Debuggin ----
	
	generate_spike_row(platform_width, platform_height, platform_width, 4)

	
func generate_spike(x_position: float, y_position: float, offset: float):
	
		var spike_instance = single_spike_scene.instantiate()
		
		spike_instance.get_node("Area2D/CollisionPolygon2D")
		
		spike_instance.position = Vector2((x_position / 2 * -1) + offset - spike_instance.getWidth(), y_position / 2 * -1)
		
		add_child(spike_instance);
	
# Function to generate a spike row based on spike count
func generate_spike_row(x_position: float, y_position: float, offset: float, spike_count: int):
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
	
	# Position the spike row
	spike_row_instance.position = Vector2((x_position / 2 * -1) + offset - spike_row_instance.getWidth(), y_position / 2 * -1)
	
	# Add the spike row instance to the current scene
	add_child(spike_row_instance)
