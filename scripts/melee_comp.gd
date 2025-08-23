extends Node2D

@export var shapecast : ShapeCast2D 
@export var animationplayer : AnimationPlayer
@export var weapon_damage : float = 4


func _ready() -> void:
	pass



func _physics_process(delta: float) -> void:
	if shapecast.is_colliding():
		var area = shapecast.get_collider(0)
		if area.is_in_group("player"):
			shapecast.collide_with_areas = false
			area.take_damage(weapon_damage)
			await get_tree().create_timer(0.4).timeout
			shapecast.collide_with_areas = true

	global_rotation -= 0.1
