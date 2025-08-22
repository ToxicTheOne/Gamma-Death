extends Node2D

# Components
@onready var bullet_component : PackedScene

# Variables
@onready var wavelenghts: Array = Autoload.wavelenghts.keys()
@onready var current_wavelenght = wavelenghts[Autoload.player_current_wavelenght]
@onready var can_shoot : bool = true
@onready var can_shoot_ai : bool = false

# Nodes
@export var player : bool
@export var areadetection : Area2D
@export var shapecast : ShapeCast2D
@export var bulletname : String

func _ready():
	if areadetection != null:
		areadetection.area_entered.connect(toggle_can_shoot)

	get_bullet()

func _physics_process(_delta: float) -> void:
	if player:
		if Input.is_action_just_pressed("shoot") and can_shoot or Input.is_action_pressed("shoot") and can_shoot:
			shoot()
	elif not player:
		pass

func shoot():
	var bullet = bullet_component.instantiate()
	if player:
		can_shoot = false
		bullet.global_position = self.global_position
		$/root/main.add_child(bullet)
		bullet.bullet_direction = (get_global_mouse_position() - global_position).normalized()
		bullet.look_at(get_global_mouse_position())
		await get_tree().create_timer(Autoload.shoot_wait_time).timeout
		can_shoot = true
	elif not player:
		can_shoot_ai = false
		bullet.global_position = self.global_position
		await get_tree().physics_frame
		$/root/main.add_child(bullet)
		bullet.bullet_direction = (get_global_mouse_position() - global_position).normalized()
		await get_tree().create_timer(Autoload.shoot_wait_time).timeout
		can_shoot_ai = true

func get_bullet():
	if player:
		match current_wavelenght:
			"radio":
				bullet_component = Autoload.bullet_nodes[0]
			"microonde":
				pass
			"infrared":
				pass
			"visible":
				pass
			"ultraviolet":
				pass
			"x-rays":
				pass
			"gammarays":
				pass
	else:
		match bulletname:
			"bullet":
				bullet_component = Autoload.enemy_bullet_nodes[0]
			"heavybullet":
				bullet_component = Autoload.enemy_bullet_nodes[1]



func toggle_can_shoot(area):
	if area.is_in_group("player"):
		shoot()
		#!can_shoot_ai 
		#await get_tree().create_timer(1).timeout
		#!can_shoot_ai 
