extends Node2D

var partidaGuardada = false
var partidaNueva = false

onready var partida = SaveManager
const pause = preload("res://Music and Sounds/Pause.wav")
const unpause = preload("res://Music and Sounds/Unpause.wav")

onready var musicaFondo = MusicaFondo
onready var soundFondo = SoundFondo

func _ready():
	for object in get_tree().get_nodes_in_group("minimap_objects"):
		object.connect("removed", $CanvasLayer/MiniMap, "_on_object_removed")

func _process(_delta):
	if partidaGuardada:
		partida.load(1)
		partidaGuardada = false
		musicaFondo.play_musica()

	if partidaNueva:
		PlayerStats.health = PlayerStats.max_health
		partidaNueva = false
		musicaFondo.play_musica()

		#Dialogo principio
		if get_node_or_null('DialogNode') == null:
			get_tree().paused = true
			var dialog = Dialogic.start('inicio_timeline-1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end',self,'resume')
			add_child(dialog)

	if Input.is_action_just_pressed("pause"):
		soundFondo.play_sound(pause)

func resume(timeline_name):
	get_tree().paused = false
