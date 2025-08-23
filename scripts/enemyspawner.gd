extends Node2D

# Variables
var enemylist : Array = Autoload.enemy_nodes.duplicate()
var enemyinfoarray : Array = Autoload.enemy_info.values()
var enemyvaluesarraymelee : Array = enemyinfoarray[0]
var enemyvaluesarrayshooter : Array = enemyinfoarray[1]
var enemyvaluesarrayheavy: Array = enemyinfoarray[2]
var random_timing : float

# Nodes
@export var player : CharacterBody2D
@onready var timer: Timer = $Timer




func spawn():
	# If it cant spawn any more enemies, return
	if Labelmanager.wave_intensity_copy <= 0:
		return
	
	Labelmanager.enemies_alive += 1
	
	# Take a random index from 0 to the enemy list
	var randomlistindex = randi_range(0,enemylist.size() - 1)
	
	# Randomize the time it takes to spawn the enemies
	random_timing = randf_range(4,6)
	timer.wait_time = random_timing
	
	# Take a random enemy with the index and instantiate it
	var randomenemy = enemylist[randomlistindex]
	var enemy = randomenemy.instantiate()
	enemy.player = player
	enemy.position = self.position
	$/root/main.add_child(enemy)
	
	match randomlistindex:
		0:
			Labelmanager.wave_intensity_copy -= enemyvaluesarraymelee[2]
			print(Labelmanager.wave_intensity_copy, " - ", enemyvaluesarraymelee[2])
		1:
			Labelmanager.wave_intensity_copy -= enemyvaluesarrayshooter[2]
			print(Labelmanager.wave_intensity_copy, " - ", enemyvaluesarrayshooter[2])
		2:
			Labelmanager.wave_intensity_copy -= enemyvaluesarrayheavy[2]
			print(Labelmanager.wave_intensity_copy, " - ", enemyvaluesarrayheavy[2])

func _on_timer_timeout() -> void:
	var chance = randi_range(1,2)
	if chance == 1:
		spawn()
	else:
		return
