extends YSort

export(PackedScene) var slime

var new_slime

onready var timer = $Timer

func _ready():
	new_slime = slime.instance()
	self.add_child(new_slime)
	new_slime.global_position = global_position

func _process(_delta):
	if !self.get_child_count() == 1:
		timer.start(60)

func _on_Timer_timeout():
	new_slime = slime.instance()
	self.add_child(new_slime)
	new_slime.global_position = global_position
