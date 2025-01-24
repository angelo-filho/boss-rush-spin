class_name ShuffleBag

var values: Array = []
var bag: Array = []

func _init(values: Array) -> void:
	self.values = values
	
	randomize()

func get_value():
	if bag.is_empty():
		bag = values.duplicate()
		bag.shuffle()

	var random_value = bag.pop_back()
	
	return random_value
