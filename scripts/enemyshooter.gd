extends CharacterBody2D

# Nodes
@onready var health_bar_comp: ProgressBar = $HealthBarComp
@onready var ai_move_comp: NavigationAgent2D = $AIMoveComp
@export var player : CharacterBody2D
@onready var driveparticle = preload("res://scenes/driveparticle.tscn")



# Variables
@onready var enemyname = "enemyshooter"
@onready var enemyinfos = Autoload.enemy_info.values()
@onready var enemytype = enemyinfos[1]
@onready var enemyhealth = enemytype[0]
@onready var enemyspeed = enemytype[1]
@onready var max_enemy_health = enemyhealth
var points : int = 3
@onready var skew_position : bool = false

func _ready() -> void:

	if player == null:
		player = Autoload.player
		ai_move_comp.movement_target = player
		$GunComp.player_node = player
	else:
		ai_move_comp.movement_target = player
		Autoload.player = player
		$GunComp.player_node = player
	
	
	health_bar_comp.initialize_health(enemyhealth)



func _physics_process(delta: float) -> void:
	$body.look_at(player.global_position)
	$GunComp.look_at(player.global_position)
	
	if skew_position == true:
		position.x -= player.position.x / 320
		position.y -= player.position.y / 320



func die():
	$HitboxComp.disable(true)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	

	tween.tween_property(self, "modulate:r", 50, 1)
	
	tween.tween_property(self, "modulate:a", 0 , 0.3).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(0.3).timeout
	
	Labelmanager.enemies_alive -= 1
	
	for i in points:
		var new_drive_particle = driveparticle.instantiate()
		new_drive_particle.player = player
		new_drive_particle.global_position = self.global_position
		$/root/main.add_child(new_drive_particle)
	
	await tween.finished
	
	queue_free()
