extends Node

# Signals
signal animatewave
signal waveend
signal wavestart

# Wave
@onready var wave: int = 0
@onready var wave_duration : int = 30
@onready var wave_intensity : float = 50.0
@onready var wave_intensity_copy : float = wave_intensity

# Time
@onready var seconds : int = 0
@onready var minutes : int = 0
@onready var totalseconds : int = 0
@onready var totalminutes : int = 0
var total_points

# Nodes
@export var secondtimer: Timer 
@export var doorspriteopen : Sprite2D
@export var doorspriteclosed : Sprite2D


func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	wave = 0
	wave_intensity = 50
	new_wave()


func stop_wave():
	waveend.emit()
	secondtimer.stop()
	calculate_drive_boost(seconds)
	# "pause" game
	# open door 


func new_wave():
	wavestart.emit()
#	secondtimer.start()
	wave += 1
	#wave_duration += wave * 1.5 waveduration is useless now
	wave_intensity += wave * 1.2
	wave_intensity_copy = wave_intensity
	animatewave.emit()



func manage_time():
	if seconds == 60:
		seconds = 0
		minutes += 1
	if totalseconds == 60:
		totalseconds = 0
		totalminutes += 1

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


func _on_totaltimer_timeout() -> void:
	totalseconds += 1
	#if wave_intensity_copy <= 0:
		#stop_wave()

func calculate_drive_boost(seconds):
	total_points = 100
	var effective_points = total_points - seconds
	var drivebonus : int = effective_points / seconds
	if drivebonus < 0:
		drivebonus = 0
	print("DRIVE BONUS IS", drivebonus)
	total_points += 10
