extends CharacterBody2D

@onready var ai_move_comp: NavigationAgent2D = $AIMoveComp
@export var player : CharacterBody2D
@onready var enemyinfos = Autoload.enemy_info.values()
@onready var enemytype = enemyinfos[0]
@onready var enemyhealth = enemytype[0]
@onready var enemyspeed = enemytype[1]

func _ready() -> void:

	if player == null:
		player = Autoload.player
	else:
		ai_move_comp.movement_target = player
		Autoload.player = player

func _physics_process(delta: float) -> void:
	$body.look_at(player.global_position)
	$MeleeComp.look_at(player.global_position)
	
	if enemyhealth <= 0:
		queue_free()
	
