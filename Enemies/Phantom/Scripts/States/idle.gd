## Idle State
class_name Phantom_State_Idle extends State

var player_in_idle_range: bool = true
var player_in_chase_range: bool = false

func Process(_delta: float) -> State:
	if !player_in_idle_range:
		player_in_idle_range = true
		return state_machine.states["Standby"]
	if player_in_chase_range:
		player_in_chase_range = false
		return state_machine.states["Chase"]
	return null

func _on_chase_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_chase_range = true


func _on_idle_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_idle_range = false
