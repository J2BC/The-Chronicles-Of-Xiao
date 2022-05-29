extends Control

var partida = SaveManager

onready var soundFondo = SoundFondo
const select_sound = preload("res://Music and Sounds/Menu Select.wav")


func _process(delta):
	# Pausa
	if Input.is_action_just_pressed("pause"):
		var new_state = not get_tree().paused
		get_tree().paused = not get_tree().paused
		visible = new_state

func _on_Cerrar_pressed():
	soundFondo.play_sound(select_sound)
	get_tree().quit()

func _on_Guardar_y_Cerrar_pressed():
	soundFondo.play_sound(select_sound)
	get_tree().paused = not get_tree().paused
	partida.save(1)
	get_tree().quit()

func _on_Guardar_y_Salir_pressed():
	soundFondo.play_sound(select_sound)
	get_tree().paused = not get_tree().paused
	partida.save(1)
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func _on_Guardar_pressed():
	soundFondo.play_sound(select_sound)
	partida.save(1)
