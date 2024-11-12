extends Area2D
# NOTE- collision mask needs to be set to whichever 
# 		layer the player on

@onready var player = $"/root/Game/Player"


func _on_body_entered(body: Node2D) -> void:
	#condition is needed to make sure that the collision is only reacting
	#to the player, and not the platform
	if(body == player):
		print("You died!")
		player.die()
		
