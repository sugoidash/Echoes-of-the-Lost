class_name PlayerUIHandler extends Control

@onready var player: Player = $".."
@onready var player_data: PlayerData = $"../PlayerData"
@onready var stamina_bar: ProgressBar = $"StaminaBar"

func _process(delta):
	if player_data.stamina < player_data.max_stamina:
		stamina_bar.show()
		stamina_bar.value = player_data.stamina
	else:
		stamina_bar.hide()
	pass
