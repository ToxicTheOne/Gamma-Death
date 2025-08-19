extends Node2D







func dash(direction :  Vector2, dash_speed : int):
	
	var parent = get_parent()
	
	# If the player is the one dashing:
	if parent.is_in_group("player"):
		parent.remove_from_group("player")
		parent.velocity.x = direction.x * dash_speed
		parent.velocity.y = direction.y * dash_speed
		await get_tree().create_timer(0.15).timeout
		parent.add_to_group("player")
	
	# If the enemy is dashing:
	elif parent.is_in_group("enemy"):
		parent.remove_from_group("enemy")
		parent.velocity.x = direction.x * dash_speed
		parent.velocity.y = direction.y * dash_speed
		await get_tree().create_timer(0.15).timeout
		parent.add_to_group("enemy")
