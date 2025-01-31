class_name BasicTimer
extends Object

var duration: float
var time: float = 0.0
var is_finished: bool:
	get:
		return time >= duration
		

func _init(duration: float) -> void:
	self.duration = duration


func run(delta: float):
	if is_finished:
		return
	
	time += delta
