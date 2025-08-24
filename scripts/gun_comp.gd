extends Node2D

# Components
@onready var bullet_component : PackedScene

# Variables
@onready var wavelenghts: Array = Autoload.wavelenghts.keys()
@onready var current_wavelenght = wavelenghts[Autoload.player_current_wavelenght]
@onready var can_shoot : bool = true
@onready var can_shoot_ai : bool = true
@export var player : bool
@export var enemyheavy_shoot_wait_time : float = 0.9
@export var enemyshooter_shoot_wait_time : float = 0.6
var shoot_wait_time : float

# Nodes
@export var player_node : CharacterBody2D
@export var shapecast : ShapeCast2D
@export var bulletname : String

func _ready():
	if shapecast == null:
		shapecast = $ShapeCast
	get_bullet()



func _physics_process(_delta: float) -> void:
	if player:
		if Input.is_action_just_pressed("shoot") and can_shoot or Input.is_action_pressed("shoot") and can_shoot:
			shoot()
	elif not player:
		if shapecast.is_colliding():
			var area = shapecast.get_collider(0)
			if area.is_in_group("player") and can_shoot_ai:
				shoot()
				#can_shoot_ai = false
				#await get_tree().create_timer(1).timeout
				#can_shoot_ai = true




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
		bullet.bullet_direction = (player_node.global_position - global_position).normalized()
		await get_tree().create_timer(enemyheavy_shoot_wait_time).timeout
		can_shoot_ai = true

func get_bullet():
	if player:
		match current_wavelenght:
			"radio":
				bullet_component = Autoload.bullet_nodes[0]
			"microonde":
				bullet_component = Autoload.bullet_nodes[1]
			"infrared":
				bullet_component = Autoload.bullet_nodes[2]
			"visible":
				bullet_component = Autoload.bullet_nodes[3]
			"ultraviolet":
				bullet_component = Autoload.bullet_nodes[4]
			"x-rays":
				bullet_component = Autoload.bullet_nodes[5]
			"gammarays":
				bullet_component = Autoload.bullet_nodes[6]
	else:
		match bulletname:
			"bullet":
				bullet_component = Autoload.enemy_bullet_nodes[0]
				shoot_wait_time = enemyshooter_shoot_wait_time
			"heavybullet":
				bullet_component = Autoload.enemy_bullet_nodes[1]
				shoot_wait_time = enemyheavy_shoot_wait_time
