extends CharacterBody2D


# Nodes
@onready var health_bar_comp: ProgressBar = $HealthBarComp
@onready var ai_move_comp: NavigationAgent2D = $AIMoveComp
@export var player : CharacterBody2D




# Variables
@onready var enemyinfos = Autoload.enemy_info.values()
@onready var enemytype = enemyinfos[0]
@onready var enemyhealth = enemytype[0]
@onready var enemyspeed = enemytype[1]
@onready var max_enemy_health = enemyhealth

func _ready() -> void:
	if player == null:
		player = Autoload.player
	else:
		ai_move_comp.movement_target = player
		Autoload.player = player
	
	health_bar_comp.initialize_health(enemyhealth)



func _physics_process(delta: float) -> void:
	$body.look_at(player.global_position)
	$MeleeComp.look_at(player.global_position) 

	



func die():
	$HitboxComp.disable(true)
	position.x -= player.position.x / 400
	position.y -= player.position.y / 400
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	

	tween.tween_property(self, "modulate:r", 50, 1)
	
	tween.tween_property(self, "modulate:a", 0 , 0.3).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	queue_free()
