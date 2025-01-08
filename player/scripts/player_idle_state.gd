extends PlayerState

func enter(message: Dictionary = {}) -> void:
	core.velocity = Vector2.ZERO


func tick(delta: float) -> void:
	pass


func input_tick(event: InputEvent) -> void:
	pass


func physics_tick(delta: float) -> void:	
	if not core.is_on_floor() or core.can_jump():
		fsm.change_state($"../Jump", { "can_jump": core.can_jump() })
		
		return
	
	if abs(core.direction) > 0:
		fsm.change_state($"../Run")
		
		return


func exit() -> void:
	pass
