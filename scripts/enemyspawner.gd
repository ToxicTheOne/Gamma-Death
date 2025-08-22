extends Node2D

# Variables
var enemylist : Array = Autoload.enemy_nodes.duplicate()
var enemyinfoarray : Array = Autoload.enemy_info.values()
var enemyvaluesarray : Array = enemyinfoarray[2]
var random_timing : float

# Nodes
@export var player : CharacterBody2D
@onready var timer: Timer = $Timer





func _ready() -> void:
	pass


func spawn():
	if Labelmanager.wave_intensity_copy <= 0:
		return
	
	var randomlistindex = randi_range(0,enemylist.size() - 1)
	
	random_timing = randf_range(3,6)
	timer.wait_time = random_timing
	
	
	var randomenemy = enemylist[randomlistindex]
	var enemy = randomenemy.instantiate()
	enemy.player = player
	enemy.position = self.position
	$/root/main.add_child(enemy)
	
	match randomlistindex:
		0:
			Labelmanager.wave_intensity_copy -= enemyvaluesarray[0]
		1:
			Labelmanager.wave_intensity_copy -= enemyvaluesarray[1]
		2:
			Labelmanager.wave_intensity_copy -= enemyvaluesarray[2]

func _on_timer_timeout() -> void:
	spawn()
