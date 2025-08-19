extends Area2D

# Gets the damage multiplier of its wavelenght
var wavelenght_values : Array = Autoload.wavelenghts.values()
var wavelenght_array : Array = wavelenght_values[0]
var wavelenght_multiplier : int = wavelenght_array[0]

# Adds to the speed and damage any upgrade boost and its wavelenght multiplier.
var bullet_damage : int = 10 * wavelenght_multiplier * Autoload.bullet_damage_boost
var bullet_speed = 8 * wavelenght_multiplier * Autoload.bullet_speed_boost
var bullet_direction : Vector2





func _physics_process(delta: float) -> void:
	global_position += bullet_direction * bullet_speed 
	global_position = floor(global_position)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage(bullet_damage)
		queue_free()
