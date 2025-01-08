extends FSM

func prepare() -> void:
	var parent = get_parent()
	
	await parent.ready
	
	for state in get_children():
		state.fsm = self
		state.core = parent
	
	current_state.enter()
