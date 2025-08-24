extends CharacterBody2D

# Variables
var can_dash : bool = true
var speed : int
var is_walking : bool

# Components
@onready var dash_component = $DashComp

# Nodes
@onready var healthbar: ProgressBar = $"healthbar"
@onready var drivelabel: RichTextLabel = $drivelabel
@export var bonuslabel: RichTextLabel 



func _ready():
	healthbar.initialize_health(Autoload.player_max_health)
	Labelmanager.animatebonuslabel.connect(animate_bonuslabel)
	if bonuslabel == null:
		bonuslabel = $bonuslabel

	

func _physics_process(delta: float) -> void:
	
	# Sets up the drive label
	drivelabel.text = str("Drive x", Autoload.drive)
	
	# Makes the body look at the mouse
	$body.look_at(get_global_mouse_position())
	
	# Sets speed
	speed = Autoload.player_speed
	
	# Picks up input
	velocity.x = Input.get_axis("left", "right") * speed 
	velocity.y = Input.get_axis("up", "down") * speed
	
	# Makes movement smooth
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	
	walk_animations()
	initiate_dash()
	
	move_and_slide()



func walk_animations():
	# Legs rotation
	if get_angle_to(get_global_mouse_position()) < -1.6:
		$legs.rotation_degrees = 210
	elif get_angle_to(get_global_mouse_position()) < 0:
		$legs.rotation_degrees = -50
	elif get_angle_to(get_global_mouse_position()) < 1.6:
		$legs.rotation_degrees = 40
	else:
		$legs.rotation_degrees = 125
	
	# Check if walking
	if Input.get_axis("left", "right") != 0: is_walking = true
	elif Input.get_axis("up", "down") != 0: is_walking = true
	else: is_walking = false
	
	# If walking, play the animation
	if is_walking == true:
		$legs/AnimationPlayer.play("walk")
	else:
		$legs/AnimationPlayer.play("RESET")

func initiate_dash():
	# If the player presses "Dash" and he can dash:
	if Input.is_action_just_pressed("dash") and can_dash:
		# If he isnt pressing any direction key, dont do anything
		if not Input.get_axis("left","right") and not Input.get_axis("up", "down"):
			return
		# Get the direction
		var direction : Vector2
		can_dash = false
		direction.x = Input.get_axis("left", "right") * 2
		direction.y = Input.get_axis("up", "down") * 2
		
		# Tell the dash component to dash in that direction and how much force to use
		dash_component.dash(direction, Autoload.player_dash_speed)
		await get_tree().create_timer(Autoload.dash_wait_time).timeout
		can_dash = true


func animate_bonuslabel():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	bonuslabel.text = str("DRIVE BONUS +", Labelmanager.drivebonus)
	

	tween.tween_property(bonuslabel, "scale", Vector2(0.4,0.4), 0.6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(bonuslabel, "scale", Vector2(0.0,0.0), 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_delay(3.6)
	
	await tween.finished
	Autoload.drive += Labelmanager.drivebonus

	
