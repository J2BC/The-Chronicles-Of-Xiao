extends Control

var partida = SaveManager
onready var save_file = File.new()
onready var musicaFondo = MusicaFondo
onready var soundFondo = SoundFondo
const musica_fondo = preload("res://Music and Sounds/MainMenuMusic.wav")
const select_sound = preload("res://Music and Sounds/Menu Select.wav")

func _ready():
	musicaFondo.play_music(musica_fondo)

func _process(_delta):
	if not save_file.file_exists("res://debug/save/save_001.tres"):
		$Menu/Cargar_Partida.disabled = true
		$Menu/Borrar_Partida.disabled = true
	else:
		$Menu/Cargar_Partida.disabled = false
		$Menu/Borrar_Partida.disabled = false

func _on_Partida_Nueva_pressed():
	soundFondo.play_sound(select_sound)
	GlobalWorld.partidaNueva = true
	get_tree().change_scene("res://World.tscn")

func _on_Cargar_Partida_pressed():
	soundFondo.play_sound(select_sound)
	GlobalWorld.partidaGuardada = true
	get_tree().change_scene("res://World.tscn")

func _on_Borrar_Partida_pressed():
	soundFondo.play_sound(select_sound)
	partida.delete()

func _on_Cerrar_pressed():
	soundFondo.play_sound(select_sound)
	get_tree().quit()
