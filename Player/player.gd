class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var stamina_bar: ProgressBar = $PlayerUI/StaminaBar

func _ready():
	state_machine.Initialize(self)
	pass
	
func _process(_delta):
	pass
	
func _physics_process(_delta):
	move_and_slide()
