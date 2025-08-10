## Standby State
class_name Phantom_State_Standby extends State

var player_in_idle_range: bool = false

func Process(_delta: float) -> State:
	if player_in_idle_range:
		player_in_idle_range = false
		return state_machine.states["Idle"]
	return null

func _on_idle_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_idle_range = true
