extends Node2D

@export var hitboxbilly : Area2D 
@export var animationplayer : AnimationPlayer
@export var weapon_damage : int = 5

func _ready() -> void:
	pass


#func swing():
	#var tween = get_tree().create_tween()
	#hitboxbilly.monitorable = true
	#hitboxbilly.monitoring = true
	#
	#
	#
	#animationplayer.play("swing")
	#await animationplayer.animation_finished
	#
	#hitboxbilly.monitorable = false
	#hitboxbilly.monitoring = false
	#animationplayer.play_backwards("swing")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.take_damage(weapon_damage)
		print("hey i touched player - meleecomp")
