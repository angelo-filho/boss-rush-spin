extends State

@export var possible_states: Array[State]

var time_state: float = 4.0
func enter(message: Dictionary = {}) -> void:
	print("Boss is idle...")
	pass

func tick(delta: float) -> void:
	time_state -= delta
	if time_state <= 0.0:
		var next_state = choose_next_state()
		time_state = 4.0
		fsm.change_state(next_state)
	pass

func choose_next_state():
	return possible_states.pick_random()
