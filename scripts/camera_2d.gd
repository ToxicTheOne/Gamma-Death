extends Camera2D

@export var player_node : CharacterBody2D
var lerp_speed = 4.0

func _physics_process(delta: float) -> void:
	
	global_position = lerp(global_position, player_node.global_position, delta * lerp_speed)
	
	global_position = floor(global_position)
	
