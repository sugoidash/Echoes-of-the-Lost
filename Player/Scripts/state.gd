##This is the template for all states
class_name State extends Node

static var player: Player
static var state_machine: PlayerStateMachine
static var player_data: PlayerData

func _ready():
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta: float) -> State:
	return null	
	
func Physics(_delta: float) -> State:
	return null
	
func Animation(_direction: Vector2) -> String:
	return ""
		
func HandleInput(_event: InputEvent) -> State:
	return null
