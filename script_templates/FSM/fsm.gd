extends FSM

func prepare() -> void:
	var parent = get_parent()
	
	for state in get_children():
		state.fsm = self
		state.core = parent
	
	current_state.enter()
