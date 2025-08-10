## Idle Phantom_State
class_name Phantom_State_Idle extends Phantom_State

var player_in_idle_range: bool = true
var player_in_chase_range: bool = false

var _wander_timer: float = 0.0
var _wander_direction: Vector2 = Vector2.ZERO

func Process(_delta: float) -> Phantom_State:
	if !player_in_idle_range:
		print("Phantom_State changed to Standby")
		player_in_idle_range = true
		return state_machine.states["Standby"]
	if player_in_chase_range:
		print("Phantom_State changed to Chase")
		player_in_chase_range = false
		return state_machine.states["Chase"]
	return null

func Physics(delta: float) -> Phantom_State:
	_wander_timer -= delta
	if _wander_timer <= 0:
		_wander_timer = phantom_data.idle_wander_time
		_pick_new_direction()

	phantom.velocity = _wander_direction * phantom_data.idle_speed	
	return null

# Correct: Use a leading underscore for "private" helper functions.
func _pick_new_direction() -> void:
	_wander_direction = Vector2.from_angle(randf_range(0, TAU)).normalized()

func _on_chase_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_chase_range = true


func _on_idle_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_idle_range = false
