extends NavigationAgent2D

@onready var movement_speed : int = 9000
@onready var movement_target 
@export var recalc_timer : Timer
@export var path_desired_dist : float = 10
@export var target_desired_dist : float = 10

@export var parent : CharacterBody2D

@onready var enemyinfos = Autoload.enemy_info.values()
@onready var enemytype = enemyinfos[0]
@onready var enemyspeed = enemytype[1]


func _ready() -> void:
	movement_speed * enemyspeed
	recalc_timer.timeout.connect(on_recalc_timer_timeout)
	velocity_computed.connect(on_velocity_computed)
	
	path_desired_distance = path_desired_dist
	target_desired_distance = target_desired_dist
	
	
	call_deferred("actor_setup")

func _physics_process(delta: float) -> void:
	if is_navigation_finished():
		return
	
	var cur_agent_pos = parent.global_position
	var next_path_pos = get_next_path_position()
	
	var new_velocity = cur_agent_pos.direction_to(next_path_pos) * movement_speed * delta
	
	if avoidance_enabled:
		set_velocity(new_velocity)
	else:
		on_velocity_computed(new_velocity)


func actor_setup():
	await get_tree().physics_frame
	set_target_position(movement_target.position)



func on_recalc_timer_timeout():
	set_target_position(movement_target.position)


func on_velocity_computed(safe_velocity : Vector2):
	parent.velocity = safe_velocity 
	parent.move_and_slide()
