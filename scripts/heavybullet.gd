extends Area2D

@export var bullet_speed : int = 5
@export var bullet_damage : int = 30
var bullet_direction : Vector2

# Destroy after X seconds
func _ready() -> void:
	await get_tree().create_timer(15).timeout
	queue_free()

# Go foward.
func _physics_process(delta: float) -> void:
	global_position += bullet_direction * bullet_speed 
	global_position = floor(global_position)


# If it collides with a player, take away damage and destroys

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.take_damage(bullet_damage)
		queue_free()
