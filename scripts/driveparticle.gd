extends Area2D

@onready var player : CharacterBody2D
@export var speed : float = randf_range(4.0,9.0)

func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, player.global_position, delta * speed)




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Autoload.drive += 1
		queue_free()
