extends Node

# Signals
signal animatewave
signal animatebonuslabel
signal waveend
signal wavestart


# Wave
@onready var wave: int = 0
@onready var wave_duration : float = 30
@onready var wave_intensity : float = 20 # Spawns double its value. so 20 = 4 enemies. Kinda
@onready var wave_intensity_copy : int = wave_intensity

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
@onready var player_entered_lab : bool = false

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	Labelmanager.wave = 0
	Labelmanager.wave_intensity = 25
	new_wave()



func stop_wave():
	print("Stop wave function is called")

	Labelmanager.stopped_wave = true
	Labelmanager.waveend.emit()
	calculate_drive_boost(seconds)
	Labelmanager.animatebonuslabel.emit()
	Labelmanager.seconds = 0
	Labelmanager.minutes = 0



func new_wave():
	Labelmanager.animatewave.emit()
	Labelmanager.stopped_wave = false
	Labelmanager.wavestart.emit()
	Labelmanager.wave += 1
	Labelmanager.wave_intensity += wave * 2
	Labelmanager.wave_intensity_copy = Labelmanager.wave_intensity
	print ("New wave function is being called, wave is ", Labelmanager.wave)
	




func manage_time():
	if Labelmanager.seconds == 60:
		Labelmanager.seconds = 0
		Labelmanager.minutes += 1
	if Labelmanager.totalseconds == 60:
		Labelmanager.totalseconds = 0
		Labelmanager.totalminutes += 1

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
	if Labelmanager.stopped_wave == false:
		Labelmanager.seconds += 1



func _on_totaltimer_timeout() -> void:
	Labelmanager.totalseconds += 1
	manage_time()
	
	if Labelmanager.enemies_alive <= 0 and Labelmanager.seconds >= 8 and Labelmanager.wave_intensity_copy <= 0 and not Labelmanager.stopped_wave:
		stop_wave()


func calculate_drive_boost(_seconds):
	# Calculates the bonus drive, total starting points:
	Labelmanager.total_points = 100
	# effective points are equal to the total minus the seconds passed
	var effective_points = Labelmanager.total_points - Labelmanager.seconds

	# if the effective points and seconds arent zero, divide them to get the drivebonus
	if effective_points != 0 and Labelmanager.seconds != 0:
		Labelmanager.drivebonus = effective_points / Labelmanager.seconds
	else:
		Labelmanager.drivebonus = 0

# if the driebonus is minus zero someway or one minute has passed, make the drive 0
	if Labelmanager.drivebonus < 0 or Labelmanager.minutes > 0:
		Labelmanager.drivebonus = 0

	# add some total points to give a bit more time each wave to the player
	Labelmanager.total_points += 10
	print("drive bonus calculated, total points:", Labelmanager.total_points, " seconds: ", Labelmanager.seconds  )


	# formula would be like TP - SEC
	#                       -------
	#                         SEC
