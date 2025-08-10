class_name PhantomStateMachine extends Node

var states: Dictionary
var prev_state: Phantom_State
var current_state: Phantom_State
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var phantom_data: Node = $"../PhantomData"
@onready var idle_range: CollisionShape2D = $"../Idle_Range/CollisionShape2D"

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	ChangeState(current_state.Process(delta))
	pass

func _physics_process(delta):
	ChangeState(current_state.Physics(delta))
	pass

func _unhandled_input(event):
	ChangeState(current_state.HandleInput(event))
	pass

func Initialize(_phantom: Phantom) -> void:
	states = {}
	
	for c in get_children():
		if c is Phantom_State:
			states[c.name] = c
	
	if states.size() == 0:
		print("Phantom has no states")
		return
	
	states["Standby"].phantom = _phantom
	states["Standby"].state_machine = self
	states["Standby"].phantom_data = phantom_data
	ChangeState(states["Standby"])
	animation_player.Initialize()
	process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState( new_state: Phantom_State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
