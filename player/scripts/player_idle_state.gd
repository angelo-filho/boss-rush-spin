extends PlayerState

func enter(message: Dictionary = {}) -> void:
	core.animation_controller.play_idle()
	core.velocity = Vector2.ZERO


func physics_tick(delta: float) -> void:	
	if not core.is_on_floor() or core.can_jump():
		fsm.change_state($"../Jump", { "can_jump": core.can_jump() })
		
		return
	
	if Input.is_action_just_pressed("dash"):
		fsm.change_state($"../Dash")
		
		return
	
	if abs(core.direction) > 0:
		fsm.change_state($"../Run")
		
		return
	
	if Input.is_action_just_pressed("attack"):
		fsm.change_state($"../Attack")
		
		return
