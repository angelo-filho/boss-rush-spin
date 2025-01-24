extends DiamondState

@export var duration: float = 4

@onready var timer: BasicTimer = BasicTimer.new(duration)

var dir: Vector2

func enter(message: Dictionary = { "dir" = Vector2.RIGHT }) -> void:
	core.went.emit()
	dir = message["dir"]


func tick(delta: float) -> void:
	timer.run(delta)
	
	if timer.is_finished:
		core.queue_free()


func physics_tick(delta: float) -> void:
	core.global_position += dir * core.speed * delta
