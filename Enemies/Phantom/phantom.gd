class_name Phantom extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PhantomStateMachine = $StateMachine
@onready var player: Player = $"../Player"
@onready var effect_range_shape = $Effect_Range/CollisionShape2D

func _ready():
	state_machine.Initialize(self)
	pass
	
func _process(_delta):
	pass
	
func _physics_process(_delta):
	move_and_slide()
