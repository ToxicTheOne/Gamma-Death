extends ProgressBar

# Health bar for enemies.

# Nodes

@onready var timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $Damagebar

# Variables
var health = 0 : set = _set_health

func initialize_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health < prev_health:
		timer.start()
	elif health > prev_health:
		damage_bar.value = health





func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(damage_bar, "value", health, 0.2).set_ease(Tween.EASE_IN)
