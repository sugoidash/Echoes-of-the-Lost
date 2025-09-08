# state_walk.gd

## Walk State
class_name State_Crawl extends State

func Enter() -> void:
	player_data.is_crawling = true

func Exit() -> void:
	player_data.is_crawling = false

func Process(_delta: float) -> State:
	# Transition to Sprint state
	if !Input.is_action_pressed("crawl") and Input.is_action_pressed("sprint") and !player_data.exhausted:
		return state_machine.states["Sprint"]
		
	# Transition to Sprint state
	if !Input.is_action_pressed("crawl") and !player_data.exhausted:
		if player_data.direction != Vector2.ZERO:
			return state_machine.states["Walk"]
		else:
			return state_machine.states["Idle"]
		
	if player_data.direction.x != 0 or player_data.direction.y != 0:
		player_data.last_direction = player_data.direction
		player.velocity.x = player_data.direction.x * player_data.crawl_speed
		player.velocity.y = -player_data.direction.y * player_data.crawl_speed
		return null
	elif player_data.exhausted:
		player.velocity = Vector2.ZERO
	else:
		return state_machine.states["Idle"]
	return null
	
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
