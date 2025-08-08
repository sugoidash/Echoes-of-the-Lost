## Idle State
class_name State_Idle extends State

func Process(_delta: float) -> State:
	if player_data.direction.x == 0 && player_data.direction.y == 0:
		player.velocity = Vector2.ZERO
		return null
	
	return state_machine.states["Walk"]
	
func Animation(_direction: Vector2) -> String:
	_direction = player_data.last_direction
	if player_data.last_direction == Vector2.ZERO:
		return ""
	player_data.last_direction = Vector2.ZERO
	if _direction.y == 0:
		if _direction.x > 0:
			return "idle_right"
		elif _direction.x < 0:
			return "idle_left"
		else:
			return ""
	else:
		if _direction.y > 0:
			return "idle_up"
		elif _direction.y < 0:
			return "idle_down"
		else:
			return ""
