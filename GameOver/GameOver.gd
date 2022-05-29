extends Control
onready var gameover = preload("res://Music and Sounds/GameOver.wav")

func _ready():
	MusicaFondo.play_sound(gameover)

func _on_Salir_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func _on_Cerrar_pressed():
	get_tree().quit()
