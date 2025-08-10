## Chase State
class_name Phantom_State_Chase extends State

var player_in_chase_range: bool = true

func Process(_delta: float) -> State:
	if !player_in_chase_range:
		player_in_chase_range = true
		return state_machine.states["Idle"]
	return null

func _on_chase_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_chase_range = false
