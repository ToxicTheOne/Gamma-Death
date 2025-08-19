extends CharacterBody2D

# Nodes
@export var collision: CollisionShape2D 
@export var sprite_face: Sprite2D 
@export var sprite_legs : Sprite2D
@export var sprite_gun : Sprite2D

# Conponents
@export var gun_conponent : Node2D 
@export var movement_component : Node2D
var parent

# Variables
@export var max_health: int = 100
@onready var current_health: int
@onready var i_am_player : bool 


func _physics_process(_delta: float) -> void:
	
	$body_node.look_at(get_global_mouse_position())
	
	if get_angle_to(get_global_mouse_position()) < -1.6:
		$legs.rotation_degrees = 180
	elif get_angle_to(get_global_mouse_position()) < 0:
		$legs.rotation_degrees = -90
	elif get_angle_to(get_global_mouse_position()) < 1.6:
		$legs.rotation_degrees = 0
	else:
		$legs.rotation_degrees = 90
	
	if $MovementComponent.is_walking == true:
		$legs/AnimationPlayer.play("walk")
	else:
		$legs/AnimationPlayer.play("RESET")
	
	
	
	move_and_slide()





func _ready() -> void:
	parent = get_parent()
	if parent.name == "Player":
		i_am_player = true
		movement_component.speed = Autoload.player_speed
	
	current_health = max_health
	

func _process(_delta: float) -> void:
	
	pass
	#if i_am_player == true:
		#assing_player_health()
		#get_child(0).global_position = self.global_position


#func assing_player_health():
	#max_health = Autoload.player_max_health
	#current_health = max_health




# when hit by attack, take damage
func _on_attack_hurtbox_area_entered(area: Area2D) -> void:
	takeDamage(area.bullet_damage)
	
	area.notify_bullet_hit()
	
	


func takeDamage(amount):
	parent.get_node("AnimationPlayer").stop()
	parent.get_node("AnimationPlayer").play("hurt")
	
	
	current_health = clampi(current_health - amount, 0, 99999)
	
	if current_health <= 0:
		defeat()
	

func defeat():
	get_tree().reload_current_scene()
	
