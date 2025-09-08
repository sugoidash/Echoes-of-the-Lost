class_name PlayerData extends Node

@export var max_speed: float = 120.0
@export var sprint_speed: float = 200.0  # Speed when sprinting
@export var crawl_speed: float = 70.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0
@export var jump_velocity: float = -350.0

@export var max_stamina: float = 100.0   # Maximum stamina
@export var stamina_regeneration_rate: float = 10.0 # Rate at which stamina regenerates
@export var stamina_consumption_rate: float = 20.0 # Rate at which stamina is consumed

var stamina: float = max_stamina       # Current stamina
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO
var exhausted: bool = false
var is_crawling: bool = false

#region VARIABLE UPDATES
func _process(_delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("up") - Input.get_action_strength("down")
	direction = direction.normalized()
	
	if stamina == 0:
		exhausted = true
	elif stamina == max_stamina:
		exhausted = false
	
	# Regenerate stamina if not sprinting
	if not Input.is_action_pressed("sprint") and stamina < max_stamina:
		stamina += stamina_regeneration_rate * _delta
		if stamina > max_stamina:
			stamina = max_stamina
#endregion
