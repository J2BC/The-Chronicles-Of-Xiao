extends Area2D

var activo = false
var dialog

onready var dialogo = $Dialogo

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_accept")and activo:
			get_tree().paused = true
			dialog = Dialogic.start('link_timeline-1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end',self,'unpause')
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
	get_parent().queue_free()

func _on_Area2D_body_entered(body):
	if body is Player:
		activo = true

func _on_Area2D_body_exited(body):
	if body is Player:
		activo = false
