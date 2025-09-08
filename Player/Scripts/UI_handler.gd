class_name PlayerUIHandler extends Control

@onready var player: Player = $".."
@onready var player_data: PlayerData = $"../PlayerData"
@onready var stamina_bar: ProgressBar = $"StaminaBar"

func _ready() -> void:
	stamina_bar.max_value = player_data.max_stamina
	stamina_bar.value = player_data.max_stamina

func _process(_delta):
	if player_data.stamina < player_data.max_stamina:
		stamina_bar.show()
		stamina_bar.value = player_data.stamina
	else:
		stamina_bar.hide()
