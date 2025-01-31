extends Camera2D

@onready var shaker_component_2d: ShakerComponent2D = $ShakerComponent2D


func shake(intensity := 1.0, duration := 1.0):
	shaker_component_2d.intensity = intensity
	shaker_component_2d.duration = duration
	
	shaker_component_2d.play_shake()
