extends Node2D

# Other
@export var player : CharacterBody2D


# Player stats
@onready var player_max_health : float = 100
@onready var player_curremt_health : float = player_max_health 
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
	"enemymelee" : [120, 1.9, 10], # HEALTH, SPEED, ITS SPAWN VALUE
	"enemyshooter" : [100, 1.5, 15],
	"enemyheavy" : [200, 1.1, 20]
	
}

var enemy_nodes : Array[PackedScene] = [
	preload("res://scenes/enemymelee.tscn"), # Billy club
	preload("res://scenes/enemyshooter.tscn"), # Shooter
	preload("res://scenes/enemyheavy.tscn"), # Heavy shooter
	]

var enemy_bullet_nodes : Array[PackedScene] = [
	preload("res://scenes/bullets/enemybullet.tscn"), # Normal
	preload("res://scenes/bullets/heavybullet.tscn"), # Heavy
	
]
