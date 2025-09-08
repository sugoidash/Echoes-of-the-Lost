# state_sprint.gd

## Sprint State
class_name State_Sprint extends State

func Process(_delta: float) -> State:

	# Transition to Idle state if there's no movement input
	if player_data.direction == Vector2.ZERO:
		return state_machine.states["Idle"]
	
	# Transition to Crawl state
	if Input.is_action_pressed("crawl") or player_data.stamina == 0:
		return state_machine.states["Crawl"]

	# Transition to Walk state if the sprint button is released
	if Input.is_action_just_released("sprint"):
		return state_machine.states["Walk"]

	# Update player velocity for sprinting
	player.velocity.x = player_data.direction.x * player_data.sprint_speed
	player.velocity.y = -player_data.direction.y * player_data.sprint_speed
	
	# Consume stamina while sprinting
	player_data.stamina -= player_data.stamina_consumption_rate * _delta
	
	# Transition to Walk state if stamina runs out
	if player_data.stamina <= 0:
		player_data.stamina = 0
		return state_machine.states["Walk"]

	return null

func Animation(_direction: Vector2) -> String:
	# Use walking animations for sprinting
	if _direction.y == 0:
		if _direction.x > 0:
			return "walk_right"
		elif _direction.x < 0:
			return "walk_left"
	else:
		if _direction.y > 0:
			return "walk_up"
		elif _direction.y < 0:
			return "walk_down"
	return ""
