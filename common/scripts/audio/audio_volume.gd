extends HSlider

@export var bus_name: String

var bus_idx: int

func _ready() -> void:
	bus_idx = AudioServer.get_bus_index(bus_name)
	
	var volume = AudioServer.get_bus_volume_db(bus_idx)
	
	value = db_to_linear(volume)
	
	self.value_changed.connect(_on_value_changed)

func _on_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))
