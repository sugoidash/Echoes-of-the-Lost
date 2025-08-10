## Standby Phantom_State
class_name Phantom_State_Standby extends Phantom_State

var player_in_idle_range: bool = false

func Enter() -> void:
	phantom.velocity = Vector2.ZERO

func Process(_delta: float) -> Phantom_State:
	if player_in_idle_range:
		print("State changed to Idle")
		player_in_idle_range = false
		return state_machine.states["Idle"]
	return null

func _on_idle_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_idle_range = true
