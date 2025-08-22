extends Node

# Variables
@export var player : bool
@export var max_health : int = 100
@onready var current_health : int = max_health
@export var parent : CharacterBody2D
@onready var already_checked : bool = false

func _process(delta: float) -> void:
	if player == true:
		max_health = Autoload.player_max_health
		current_health = Autoload.player_curremt_health
	elif player == false:
		current_health = parent.enemyhealth
		max_health = parent.max_enemy_health
	if already_checked == false:
		check_for_death()




# Enemy functions
func take_damage(amount):
	current_health -= amount

func gain_health(amount):
	current_health += amount
	if current_health > max_health:
		current_health = max_health

func check_for_death():
	if player == false and current_health <= 0:
		parent.die()
		parent.skew_position = true
		already_checked = true
