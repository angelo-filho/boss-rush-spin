extends DiamondState

@export var duration: float = 1.5
var target: Node2D
var dir: Vector2

func enter(message: Dictionary = {}) -> void:
	target = core.player
	wait_to_change()


func tick(delta: float) -> void:
	dir = global_position.direction_to(target.global_position)
	
	core.rotation = dir.angle()


func wait_to_change():
	await get_tree().create_timer(duration + core.wait_delay).timeout
	
	fsm.change_state($"../Attack", { "dir": dir })
