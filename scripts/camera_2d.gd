extends Camera2D

@export var player_node : CharacterBody2D
var lerp_speed = 6.0
@onready var wave_label: RichTextLabel = $wavelabel




func _ready() -> void:
	Labelmanager.animatewave.connect(animate_wave_label)



func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, player_node.global_position, delta * lerp_speed)
	
	global_position = floor(global_position)
	


func animate_wave_label():
	var tween = get_tree().create_tween()
	wave_label.text = str("WAVE ", Labelmanager.wave)
	
	tween.tween_property(wave_label, "position:y", wave_label.position.y + 150, 0.5).set_ease(Tween.EASE_IN)
	tween.tween_property(wave_label, "modulate:a", 0, 1.3).set_ease(Tween.EASE_OUT).set_delay(2)
	tween.tween_property(wave_label, "position:y", wave_label.position.y - 150, 0.1)
	tween.tween_property(wave_label, "modulate:a", 255, 0.1)
	
