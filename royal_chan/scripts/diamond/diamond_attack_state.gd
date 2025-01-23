extends DiamondState

var dir: Vector2

func enter(message: Dictionary = { "dir" = Vector2.RIGHT }) -> void:
	core.went.emit()
	dir = message["dir"]


func physics_tick(delta: float) -> void:
	core.global_position += dir * core.speed * delta
