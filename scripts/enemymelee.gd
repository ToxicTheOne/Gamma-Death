extends CharacterBody2D


# Nodes
@onready var health_bar_comp: ProgressBar = $HealthBarComp
@onready var ai_move_comp: NavigationAgent2D = $AIMoveComp
@export var player : CharacterBody2D
@onready var melee_comp: Node2D = $MeleeComp



# Variables
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
	
	health_bar_comp.initialize_health(enemyhealth)



func _physics_process(delta: float) -> void:
	$body.look_at(player.global_position)
	melee_comp.look_at(player.global_position)
	$detectionarea.look_at(player.global_position)
	if enemyhealth <= 0:
		die()
	



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


func _on_detectionarea_area_entered(area: Area2D) -> void:
	melee_comp.swing()
