extends StaticBody2D


@onready var doorspriteclosed: Sprite2D = $doorspriteclosed
@onready var doorspriteopen: Sprite2D = $doorspriteopen


func _ready() -> void:
	Labelmanager.waveend.connect(on_wave_end)
	Labelmanager.wavestart.connect(on_wave_start)


func on_wave_start():
	doorspriteclosed.visible = true
	doorspriteopen.visible = false

func on_wave_end():
	doorspriteclosed.visible = false
	doorspriteopen.visible = true
