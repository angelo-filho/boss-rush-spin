extends FSM

func prepare() -> void:
	var parent = get_parent()
	
	await parent.ready
	
	for state: State in get_children():
		state.fsm = self
		state.core = parent
	
	current_state.enter()
