extends YSort

export(PackedScene) var bat

var new_bat

onready var timer = $Timer

func _ready():
	new_bat = bat.instance()
	self.add_child(new_bat)
	new_bat.global_position = global_position


func _process(_delta):
	if !self.get_child_count() == 1:
		timer.start(10)

func _on_Timer_timeout():
	new_bat = bat.instance()
	self.add_child(new_bat)
	new_bat.global_position = global_position
