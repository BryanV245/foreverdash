extends Node2D


# Called when the node enters the scene tree for the first time.
# Load the platform scene 
var platform_scene = preload("res://scenes/Testing/test_platform.tscn")

@onready var player = $"/root/Game/Player"

func _ready():
	generate_platform();

func generate_platform():
	
	var platform_instance = platform_scene.instantiate()
	
	platform_instance.get_node("StaticBody2D/CollisionShape2D").shape = RectangleShape2D.new()

	# Set platform position (Platform node position)
	platform_instance.position = Vector2(0, 0)

	var static_body = platform_instance.get_node("StaticBody2D")
	
	static_body.set_platform_size(100000, 100)

	# Add the platform (root node) to the scene
	add_child(platform_instance)
