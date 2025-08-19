extends Node2D

 # Nodes
@export var legs : Sprite2D
@export var actor : CharacterBody2D 

# Variables
@onready var speed : int
@export var dash_component : Node = null
var can_dash = true

# walk mechanics
var is_walking = false


func _physics_process(_delta: float) -> void:
	
	actor.velocity.x = Input.get_axis("left", "right") * speed
	actor.velocity.y = Input.get_axis("up", "down") * speed
	
	
	# detect if you're inputting walk for animation
	if Input.get_axis("left", "right") != 0: is_walking = true
	elif Input.get_axis("up", "down") != 0: is_walking = true
	else: is_walking = false
	
	
	actor.velocity = lerp(actor.get_real_velocity(), actor.velocity, 0.1)
	
	
	
	
	if Input.is_action_just_pressed("dash") and can_dash:
		if not Input.get_axis("left","right") and not Input.get_axis("up", "down"):
			return
		var direction : Vector2
		can_dash = false
		direction.x = Input.get_axis("left", "right") * 2
		direction.y = Input.get_axis("up", "down") * 2
		
		dash_component.dash(direction)
		await get_tree().create_timer(Autoload.dash_wait_time).timeout
		can_dash = true
	
	
	
	
	
