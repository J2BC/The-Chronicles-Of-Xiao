extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_hearts(value):
	# Esto es para que la vida nunca sea menor a 0 ni mayor al maximo
	hearts = clamp(value, 0, max_hearts)
	
	# Con esto hacemos mas grande el tileset de corazones para que ponga mas vida
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
	

func set_max_hearts(value):
	# Esto es para que el maximo nunca sea menor a 1
	max_hearts = max(value, 1)
	
	# Con esto hacemos que la vida no pueda ser mayor a la vida maxima
	self.hearts = min(hearts, max_hearts)
	
	# Con esto hacemos mas grande el tileset de corazones para que ponga mas vida
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = hearts * 15

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearts")
# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
