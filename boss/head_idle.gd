extends State

var time_state: float = 4.0
func enter(message: Dictionary = {}) -> void:
	print("Head is idle...")
	pass

func tick(delta: float) -> void:
	time_state -= delta
	if time_state <= 0.0:
		print("change state: Attack")
		time_state = 4.0
		fsm.change_state($"../HeadAttack")
	pass
