class_name Phantom_State extends Node

static var phantom: Phantom
static var phantom_state_machine: PhantomStateMachine
static var phantom_data: PhantomData

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
