## Walk State
class_name State_Walk extends State

func Process(_delta: float) -> State:
	if player_data.direction.x != 0 || player_data.direction.y != 0:
		player_data.last_direction = player_data.direction
		player.velocity.x = player_data.direction.x * player_data.max_speed
		player.velocity.y = -player_data.direction.y * player_data.max_speed
		return null
	
	return state_machine.states["Idle"]
	
func Animation(_direction: Vector2) -> String:
	if _direction.y == 0:
		if _direction.x > 0:
			return "walk_right"
		elif _direction.x < 0:
			return "walk_left"
		else:
			return ""
	else:
		if _direction.y > 0:
			return "walk_up"
		elif _direction.y < 0:
			return "walk_down"
		else:
			return ""
