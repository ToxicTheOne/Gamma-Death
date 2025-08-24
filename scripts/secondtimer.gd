extends Timer


func _ready():
	Labelmanager.waveend.connect(stopcounting)
	Labelmanager.wavestart.connect(startcounting)


func stopcounting():
	self.stop()


func startcounting():
	self.start()
