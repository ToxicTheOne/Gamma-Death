extends Node2D





func _ready() -> void:
	Labelmanager.waveend.connect(spawn_upgrades)
	Labelmanager.wavestart.connect(despawn_upgrades)

const upgrades : Dictionary = { # SCENE 
	"Next Wavelenght" : [],
	#"infrared bullet" : [],
	#"visible bullet" : [],
	#"ultraviolet bullet" : [],
	#"x-ray bullet" : [],
	#"gamma bullet" : [],
	"speed upgrade" : [],
	"damage upgrade" : [],
	"bullet damage upgrade" : [],
	"dash distance upgrade" : [],
	"dash cooldown upgrade" : [],
}


func spawn_upgrades():
	pass
	
	
	


func despawn_upgrades():
	pass
