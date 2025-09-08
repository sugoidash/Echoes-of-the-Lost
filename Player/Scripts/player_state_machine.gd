class_name PlayerStateMachine extends Node

var states: Dictionary
var prev_state: State
var current_state: State
var is_dead: bool = false
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var player_data: Node = $"../PlayerData"

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	ChangeState(current_state.Process(delta))
	animation_player.AnimationUpdate(current_state, player_data.direction)
	pass

func _physics_process(delta):
	ChangeState(current_state.Physics(delta))
	pass

func _unhandled_input(event):
	ChangeState(current_state.HandleInput(event))
	pass

func Initialize(_player: Player) -> void:
	states = {}
	
	for c in get_children():
		if c is State:
			states[c.name] = c
	
	if states.size() == 0:
		print("Player has no states")
		return
	
	states["Idle"].player = _player
	states["Idle"].state_machine = self
	states["Idle"].player_data = player_data
	ChangeState(states["Idle"])
	animation_player.Initialize()
	process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState( new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	print(new_state)
	current_state.Enter()


func _on_area_2d_body_entered(body):
	if is_dead:
		return
		
	# Check if the colliding body is in the "enemies" group.
	if body.is_in_group("enemies"):
		# Set the flag to true immediately to prevent this from running again.
		is_dead = true
		
		# Emit the global signal via the EventHandler.
		EventHandler.emit_signal("player_died")
		
		# Disable the player character after death.
		# This prevents further movement or interaction.
		set_physics_process(false)
		process_mode = Node.PROCESS_MODE_DISABLED
		# You could also hide the player: hide()
