extends StaticBody2D

var plat_width = 0
var plat_height = 0

var platform_scene = preload("res://scenes/platform.tscn")
var single_spike_scene = preload("res://scenes/obstacles/spikes_single.tscn")
var double_spike_scene = preload("res://scenes/obstacles/spikes_double.tscn")
var triple_spike_scene = preload("res://scenes/obstacles/spikes_tripple.tscn")
var quadruple_spike_scene = preload("res://scenes/obstacles/spikes_quadruple.tscn")

var max_platforms = 20

#the current_spike_chain data member stores the current value highest size spike chain possible
var current_spike_chain = 1

var rng = RandomNumberGenerator.new()

# Function to adjust platform size (visual and collision)
func set_platform_size(width: float, height: float, platform_count: int):
	
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
	if(platform_count >= 1 ):
		
		generate_spike_row(width, height, mainSpikeRow(platform_count))    #generates the main spike row
		secondarySpikes(width, height, mainSpikeRow(platform_count))
		
#function to generate spike and place it on the platform
func generate_spike_row(width: float, height: float, spike_count: int):
	# Choose the correct spike scene based on spike_count
	var spike_row_scene
	match spike_count:
		0: 
			return
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
	
	var offset = randi_range(0, width - spike_row_instance.getWidth())
	# Position the spike row
	spike_row_instance.position = Vector2((width / 2 * -1) + offset, height / 2 * -1)

	# Add the spike row instance to the current scene
	add_child(spike_row_instance)
	
	
#Function to randomly place various spike obstacles
func secondarySpikes(width: float, height: float, mainSpike: float):
	var spikeCount = randi_range(1, 3)
	var section = width
	#for loop iterates a random(ish) number of times generating random spike rows
	#with the chain limit being the mainSpike
	for i in range(spikeCount):
		section = section-width / (spikeCount*2)
		generate_spike_row(section, height, randi_range(0, mainSpike-1))

#Function to calculate the main spike row
func mainSpikeRow(platformCount: float):
	if platformCount >= 1 && platformCount < (max_platforms/4):
		return randi_range(0,1)
	else:
		if platformCount >= (max_platforms/4) && platformCount < (max_platforms/3):
			return randi_range(1,2)
		else: 
			if platformCount >= (max_platforms/3) && platformCount < (max_platforms / 2):
				return randi_range(2,3)
			else:
				if platformCount >= (max_platforms/2) && platformCount < max_platforms:
					return randi_range(3,4)
				else: 
					return 4
