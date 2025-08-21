extends Area2D

# IF THIS IS INSIDE AN ENEMY, PUT THIS NODE IN GROUP "ENEMY"
# THIS NODE IS NOT REALLY NEEDED TBH.
@export var player : bool
@onready var current_health : int



func take_damage(damage):
	var parent = get_parent()
	current_health = parent.enemyhealth
	current_health -= damage
	Autoload.display_damage(damage, parent.position)
	parent.enemyhealth = current_health 


func _on_area_entered(area: Area2D) -> void:
	pass
