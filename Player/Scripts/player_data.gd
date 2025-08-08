class_name PlayerData extends Node

@export var max_speed: float = 120.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0
@export var jump_velocity: float = -350.0

var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO

#region VARIABLE UPDATES
func _process(_delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("up") - Input.get_action_strength("down")
	direction = direction.normalized()
#endregion
