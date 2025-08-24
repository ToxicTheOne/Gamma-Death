extends Area2D

# IF THIS IS INSIDE AN ENEMY, PUT THIS NODE IN GROUP "ENEMY"
# THIS NODE IS NOT REALLY NEEDED TBH.
@export var player : bool
@onready var current_health : int
@export var other_collision : CollisionShape2D
@export var health_bar_comp: ProgressBar 
@export var playerhealthbar: ProgressBar 



func _ready() -> void:
	pass


func disable(disabled : bool):
	if disabled == true:
		monitoring = false
		monitorable = false
		other_collision.disabled = true

func take_damage(damage):
	if player == false:
		var parent = get_parent()
		current_health = parent.enemyhealth
		current_health -= damage
		Labelmanager.display_damage(damage, parent.position)
		parent.enemyhealth = current_health 
		health_bar_comp.health = current_health

	elif player:
		Autoload.player_curremt_health -= damage
		playerhealthbar.health = Autoload.player_curremt_health 
	
func _on_area_entered(area: Area2D) -> void:
	pass
