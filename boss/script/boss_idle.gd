extends State

@export var possible_states: Array[State]

var time_state: float = 4.0
var shuffle_bag: ShuffleBag

func _ready() -> void:
	shuffle_bag = ShuffleBag.new(possible_states)


func tick(delta: float) -> void:
	time_state -= delta
	if time_state <= 0.0:
		var next_state = choose_next_state()
		time_state = 4.0
		fsm.change_state(next_state)


func choose_next_state():
	return shuffle_bag.get_value()
