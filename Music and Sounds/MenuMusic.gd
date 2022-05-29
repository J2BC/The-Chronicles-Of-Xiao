extends AudioStreamPlayer

var musica : Array = [
	"res://Music and Sounds/MusicJuego_1.wav",
	"res://Music and Sounds/MusicJuego_2.wav",
	"res://Music and Sounds/MusicJuego_3.wav",
]

var index

func _process(_delta):
	index = randi() % musica.size() - 1
	
func play_musica():
	self.stream = load(musica[index])
	self.play()

func play_music(music):
	self.stream = music
	self.play()
	self.set_volume_db(-10)

func play_sound(sound):
	self.stream = sound
	self.play()


func _on_MusicaFondo_finished():
	self.stream = load(musica[index])
	self.play()
