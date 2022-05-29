extends KinematicBody2D

class_name Player

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

enum {
	MOVE,
	ROLL,
	ATTACK
}

var velocidad = Vector2.ZERO
var state = MOVE
var roll_vector = Vector2.DOWN

export var MAX_SPEED = 80
export var ACELERACION = 500
export var FRICCION = 500
export var ROLL_SPEED = 120
var stats = PlayerStats

onready var SAVE_KEY : String = "player"

# FUNCION PARA GUARDAR LOS DATOS.
func save(save_game : Resource):
	print("he guardado la partida")
	save_game.data[SAVE_KEY] = {
		'x_pos': position.x, #Su posición en X
		'y_pos': position.y, #Su posición en Y
		'stats': {
			'hearts' : stats.health
		}
	}

# FUNCION PARA CARGAR LOS DATOS.
func load(save_game : Resource): # Con esta funcion vamos a cargar los valores de nuestro archivo de guardado
	print("he cargado la partida")
	position.x = save_game.data[SAVE_KEY].x_pos # Su posicion en x
	position.y = save_game.data[SAVE_KEY].y_pos # Su posicion en y
	stats.health = save_game.data[SAVE_KEY].stats.hearts # Vida restante

# variables para las animaciones del personaje
onready var animacionPlayer = $AnimationPlayer
onready var blinkAnimationPlayer = $BlinkAnimarionPlayer
onready var animacionTree = $AnimationTree
onready var animacionState = animacionTree.get("parameters/playback")

# Con esto podemos hacer que el knockback de los enemigos vaya segun desde donde les peguemos
onready var swordHitBox = $HitboxPivot/SwordHitbox

onready var hurtBox = $HurtBox

# Activamos el arbol de animaciones
func _ready():
	randomize()
	#stats.connect("no_health", self, "queue_free")
	animacionTree.active = true
	
	# Con esto podemos hacer que el knockback de los enemigos vaya segun desde donde les peguemos
	swordHitBox.knockback_vector = roll_vector

# Metodo principal se ejecuta cada frame
func _physics_process(delta):
	# Esto es un switch de java con los casos de un enum
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state()
			
		ATTACK:
			attack_state()

# Metodo para el movimiento del personaje
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Con esto de aqui se recalcula la posicion para que en diagonal no corra mas
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		
		# Con esto podemos hacer que el knockback de los enemigos vaya segun desde donde les peguemos
		swordHitBox.knockback_vector = input_vector
		
		animacionTree.set("parameters/Idle/blend_position", input_vector)
		animacionTree.set("parameters/Run/blend_position", input_vector)
		animacionTree.set("parameters/Attack/blend_position", input_vector)
		animacionTree.set("parameters/Roll/blend_position", input_vector)
		animacionState.travel("Run")
		
		# Aqui calculo la velocidad segun la aceleracion y la velocidad maxima junto con los fotogramas
		velocidad = velocidad.move_toward(input_vector * MAX_SPEED, ACELERACION * delta)
	else:
		animacionState.travel("Idle")
		velocidad = velocidad.move_toward(Vector2.ZERO, FRICCION * delta)

	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func roll_state():
	velocidad = roll_vector * ROLL_SPEED
	animacionState.travel("Roll")
	move()

func move():
	velocidad = move_and_slide(velocidad)

func attack_state():
	velocidad = Vector2.ZERO
	animacionState.travel("Attack")

func attack_animation_finished():
	state = MOVE
	
func roll_animation_finished():
	velocidad = velocidad * 0.8
	state = MOVE

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	hurtBox.start_invencibility(0.6)
	hurtBox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	

func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
