class_name AnimationHandler extends AnimationPlayer

func Initialize() -> void:
	self.current_animation = "idle_down"

func AnimationUpdate(_current_state: State, _direction: Vector2) -> void:
	self.current_animation = _current_state.Animation(_direction)
	pass
