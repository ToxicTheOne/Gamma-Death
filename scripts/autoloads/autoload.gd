extends Node2D

# Other
@onready var seconds
@onready var wave
@export var player : CharacterBody2D

# Player stats
@onready var player_max_health : float = 100
@onready var player_curremt_health : float
@onready var player_speed : int = 300
@onready var player_dash_speed : int = 400.0
@onready var drive : int
@onready var player_current_wavelenght : int = 0

# Player stats boosts obtainable with upgrades
@onready var bullet_damage_boost : int = 1
@onready var bullet_speed_boost : int = 1

# Wait times
@onready var shoot_wait_time : float = 0.35
@onready var dash_wait_time : float = 1


func _ready() -> void:
	pass



const wavelenghts : Dictionary = { # Wave name : Multiplier for bullet
	"radio" : [1],
	"microonde" : [1.5],
	"infrared" : [1.8],
	"visible" : [2],
	"ultraviolet" : [2.4],
	"x-rays": [2.7],
	"gammarays": [3]
}



var bullet_nodes : Array[PackedScene] = [
	preload("res://scenes/bullets/radiobullet.tscn"),
	
	
]

var enemy_info : Dictionary = {
	"enemymelee" : [120, 1.7], # HEALTH, SPEED
	"enemyshooter" : [100, 1.5],
	"enemyheavy" : [200, 1.2]
	
}


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
	
	
