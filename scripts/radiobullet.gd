extends Area2D

# Gets the damage multiplier of its wavelenght
var wavelenght_values : Array = Autoload.wavelenghts.values()
var wavelenght_array : Array = wavelenght_values[0]
var wavelenght_multiplier : int = wavelenght_array[0]

# Adds to the speed and damage any upgrade boost and its wavelenght multiplier.
var bullet_damage : int = 10 * wavelenght_multiplier * Autoload.bullet_damage_boost
var bullet_speed = 8 * wavelenght_multiplier * Autoload.bullet_speed_boost
var bullet_direction : Vector2

# Destroy after X seconds
func _ready() -> void:
	await get_tree().create_timer(10).timeout
	queue_free()

# Go foward.
func _physics_process(delta: float) -> void:
	global_position += bullet_direction * bullet_speed 
	global_position = floor(global_position)


# If it collides with an enemy, take away damage and destroys

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage(bullet_damage)
		queue_free()
