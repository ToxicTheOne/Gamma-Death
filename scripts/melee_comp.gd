extends Node2D

@export var hitboxbilly : Area2D 
@export var animationplayer : AnimationPlayer

func _ready() -> void:
	hitboxbilly.monitorable = false
	hitboxbilly.monitoring = false


func swing():
	var tween = get_tree().create_tween()
	hitboxbilly.monitorable = true
	hitboxbilly.monitoring = true
	
	
	
	animationplayer.play("swing")
	await animationplayer.animation_finished
	
	hitboxbilly.monitorable = false
	hitboxbilly.monitoring = false
	animationplayer.play_backwards("swing")
