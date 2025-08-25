extends Camera2D

@export var player_node : CharacterBody2D
var lerp_speed = 9.0
@onready var wave_label: RichTextLabel = $wavelabel




func _ready() -> void:
	Labelmanager.animatewave.connect(animate_wave_label)



func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, player_node.global_position, delta * lerp_speed)
	
	global_position = floor(global_position)
	


func animate_wave_label():
	print("THE WAVE LABEL FUNC IS BEING CALLED")
	var tween = get_tree().create_tween()
	
	wave_label.text = str("WAVE ", Labelmanager.wave)
	
	tween.tween_property(wave_label, "position:y", wave_label.position.y + 150, 0.7).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	#tween.tween_property(wave_label, "modulate:a", 0, 1.3)
	tween.tween_property(wave_label, "position:y", wave_label.position.y - 5, 0.8).set_trans(Tween.TRANS_BACK).set_delay(2)
	#tween.tween_property(wave_label, "modulate:a", 255, 1).set_delay(0.3)
	
