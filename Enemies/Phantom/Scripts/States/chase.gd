## Chase Phantom_State
class_name Phantom_State_Chase extends Phantom_State

var player_in_chase_range: bool = true
var _direction: Vector2 = Vector2.ZERO

func Process(_delta: float) -> Phantom_State:
	if !player_in_chase_range:
		player_in_chase_range = true
		print("Phantom_State changed to Idle")
		return state_machine.states["Idle"]
	return null
	
func Physics(_delta: float) -> Phantom_State:
	_direction = phantom.global_position.direction_to(phantom.player.global_position)
	phantom.velocity = Vector2(_direction*phantom_data.chase_speed)
	return null

func _on_chase_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_chase_range = false
