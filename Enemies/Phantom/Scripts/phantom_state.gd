class_name Phantom_State extends Node

static var phantom: Phantom
static var state_machine: PhantomStateMachine
static var phantom_data: PhantomData

func _ready():
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta: float) -> Phantom_State:
	return null	
	
func Physics(_delta: float) -> Phantom_State:
	return null
	
func Animation(_direction: Vector2) -> String:
	return ""
		
func HandleInput(_event: InputEvent) -> Phantom_State:
	return null
