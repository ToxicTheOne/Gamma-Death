extends Node2D

@onready var bullet_component : PackedScene
@export var shapecast : ShapeCast2D
@onready var wavelenghts: Array = Autoload.wavelenghts.keys()
@onready var current_wavelenght = wavelenghts[Autoload.player_current_wavelenght]
@onready var can_shoot : bool = true
@export var player : bool


func _ready():
	get_bullet()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot or Input.is_action_pressed("shoot") and can_shoot:
		shoot()


func shoot():
	can_shoot = false
	var bullet = bullet_component.instantiate()
	bullet.global_position = self.global_position
	$/root/main.add_child(bullet)
	bullet.bullet_direction = (get_global_mouse_position() - global_position).normalized()
	bullet.look_at(get_global_mouse_position())
	await get_tree().create_timer(Autoload.shoot_wait_time).timeout
	can_shoot = true

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
		bullet_component = Autoload.enemy_bullet
