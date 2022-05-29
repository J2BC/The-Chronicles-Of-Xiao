extends StaticBody2D

class_name Crate

signal removed

var abrirCofre = false
var minimap_icon = "alert"
var soundFondo = SoundFondo
onready var animacionCofre = $AnimatedSprite

const cofre = preload("res://Music and Sounds/Cofre.wav")

func _process(_delta):
	if Input.is_action_pressed("ui_accept") and abrirCofre:
		emit_signal("removed", self)
		soundFondo.play_sound(cofre)
		animacionCofre.play()

func _on_AreaCofre_body_entered(body):
	if body is Player:
		abrirCofre = true

func _on_AreaCofre_body_exited(body):
	if body is Player:
		abrirCofre = false
