extends Node2D



@onready var dash_comp : Node2D = $"."
@export var dashbar : ProgressBar 
@export var hitbox : Area2D

func dash(direction :  Vector2, dash_speed : int):
	
	var parent = get_parent()
	
	# If the player is the one dashing:
	if parent.is_in_group("player"):
		hitbox.remove_from_group("player")
		emptybar()
		parent.velocity.x = direction.x * dash_speed
		parent.velocity.y = direction.y * dash_speed
		await get_tree().create_timer(0.50).timeout
		fillbar()
		await get_tree().create_timer(0.30).timeout
		hitbox.add_to_group("player")
	
	# If the enemy is dashing:
	elif parent.is_in_group("enemy"):
		hitbox.remove_from_group("enemy")
		parent.velocity.x = direction.x * dash_speed
		parent.velocity.y = direction.y * dash_speed
		await get_tree().create_timer(0.70).timeout
		hitbox.add_to_group("enemy")



func emptybar():
	var tween = get_tree().create_tween()
	
	tween.tween_property(dashbar, "value", 0, 0.4).set_trans(Tween.TRANS_EXPO)

func fillbar():
	var tween = get_tree().create_tween()
	
	tween.tween_property(dashbar, "value", 100, 0.4).set_trans(Tween.TRANS_EXPO).set_delay(0.2)
