extends StaticBody2D


@onready var doorspriteclosed: Sprite2D = $doorspriteclosed
@onready var doorspriteopen: Sprite2D = $doorspriteopen
@onready var collisiondoor: CollisionShape2D = $Collisiondoor


func _ready() -> void:
	Labelmanager.waveend.connect(on_wave_end)
	Labelmanager.wavestart.connect(on_wave_start)
	

func on_wave_start():
	doorspriteclosed.visible = true
	doorspriteopen.visible = false
	await get_tree().physics_frame
	collisiondoor.disabled = false

func on_wave_end():
	doorspriteclosed.visible = false
	doorspriteopen.visible = true
	await get_tree().physics_frame
	collisiondoor.disabled = true


func _on_arealab_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and Labelmanager.player_entered_lab == false:
		print("the player entered the lab")
		Labelmanager.player_entered_lab = true


func _on_arealab_area_exited(area: Area2D) -> void:
		if area.is_in_group("secondaryplayer") and Labelmanager.player_entered_lab == true:
			print("the player exited the lab")
			Labelmanager.new_wave()
