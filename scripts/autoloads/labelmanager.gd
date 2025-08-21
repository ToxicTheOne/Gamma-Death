extends Node

# Signals
signal animatewave

# Wave
@onready var wave: int
@onready var wave_duration : int
@onready var wave_intensity : float

# Time
@onready var seconds : int = 0
@export var secondtimer: Timer 



func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	wave = -1
	wave_duration = 30
	wave_intensity = 1
	new_wave()


func stop_wave():
	# "pause" game
	# open door 
	pass

func new_wave():
	wave += 1
	wave_duration += wave * 1.5
	wave_intensity += wave * 0.5
	animatewave.emit()



func manage_time():
	if seconds >= wave_duration:
		stop_wave()


func display_damage(value, position: Vector2):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	number.label_settings.outline_color = "#888"
	number.label_settings.outline_size = 1.9
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	

	tween.tween_property(number, "position:y", number.position.y - randi_range(50,75), 0.2).set_ease(Tween.EASE_IN)
	tween.tween_property(number, "position:x", number.position.x + randi_range(-30,30), 0.1).set_ease(Tween.EASE_IN)
	tween.tween_property(number, "modulate:a", 0, 0.2).set_ease(Tween.EASE_OUT).set_delay(0.31)

	
	await tween.finished
	number.queue_free()


func _on_secondtimer_timeout() -> void:
	seconds += 1
