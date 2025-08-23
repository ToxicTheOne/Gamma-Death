extends Node

# Signals
signal animatewave
signal animatebonuslabel
signal waveend
signal wavestart


# Wave
@onready var wave: int = 0
@onready var wave_duration : int = 30
@onready var wave_intensity : int = 15 # Spawns double its value. so 20 = 4 enemies. Kinda
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

# Variables
@onready var enemies_alive : int = 0
@onready var stopped_wave : bool = false
@onready var drivebonus : int = 0

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	wave = 0
	wave_intensity = 15
	new_wave()


func stop_wave():
	waveend.emit()
	secondtimer.stop()
	calculate_drive_boost(seconds)
	Labelmanager.animatebonuslabel.emit()
	# "pause" game
	# open door 


func new_wave():
	stopped_wave = false
	wavestart.emit()
	wave += 1
	wave_intensity += wave * 0.8
	wave_intensity_copy = wave_intensity
	Labelmanager.animatewave.emit()



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

	if Labelmanager.enemies_alive <= 0 and seconds >= 8 and not stopped_wave:
		stop_wave()
		stopped_wave = true

func calculate_drive_boost(_seconds):
	total_points = 100
	var effective_points = total_points - seconds
	Labelmanager.drivebonus = effective_points / seconds
	if Labelmanager.drivebonus < 0:
		Labelmanager.drivebonus = 0
	print("DRIVE BONUS IS ", Labelmanager.drivebonus)
	total_points += 10
