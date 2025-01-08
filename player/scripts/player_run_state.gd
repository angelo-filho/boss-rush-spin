extends PlayerState

func enter(message: Dictionary = {}) -> void:
	pass


func tick(delta: float) -> void:
	pass


func input_tick(event: InputEvent) -> void:
	pass


func physics_tick(delta: float) -> void:
	if not core.is_on_floor() or core.can_jump():
		fsm.change_state($"../Jump", { "can_jump": core.can_jump() })
		
		return
	
	if abs(core.direction) == 0:
		fsm.change_state($"../Idle")
		
		return
	
	core.move_horizontaly()


func exit() -> void:
	pass
