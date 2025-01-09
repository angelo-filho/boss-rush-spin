extends State

var time_state: float = 4.0
func enter(message: Dictionary = {}) -> void:
	print("Arm Right is Attacking...")
	pass

func tick(delta: float) -> void:
	time_state -= delta
	if time_state <= 0.0:
		time_state = 4.0
		fsm.change_state($"../Idle")
	pass
