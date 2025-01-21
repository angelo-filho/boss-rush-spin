extends PlayerState

func enter(message: Dictionary = {}) -> void:
	core.animation_controller.play_run()


func physics_tick(delta: float) -> void:
	if not core.is_on_floor() or core.can_jump():
		fsm.change_state($"../Jump", { "can_jump": core.can_jump() })
		
		return
	
	if abs(core.direction) == 0:
		fsm.change_state($"../Idle")
		
		return
	
	if Input.is_action_just_pressed("attack"):
		fsm.change_state($"../Attack")
		
		return
	
	if Input.is_action_just_pressed("dash"):
		fsm.change_state($"../Dash")
		
		return
	
	
	core.move_horizontaly()
