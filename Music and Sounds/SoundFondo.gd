extends AudioStreamPlayer

func play_sound(sound):
	self.stream = sound
	self.play()
