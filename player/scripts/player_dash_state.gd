extends PlayerState

@export var speed: float = 500
@export var duration: float = 0.75

@onready var ghost_trail_controller: GhostTrailController = $"../../GhostTrailController"


func enter(message: Dictionary = {}) -> void:
	core.animation_controller.play_dash()
	ghost_trail_controller.play_ghost_trail.call_deferred(duration)
	core.velocity = Vector2.RIGHT * core.last_direction * speed
	wait_to_change_state()


func wait_to_change_state():
	await get_tree().create_timer(duration).timeout
	
	fsm.change_state($"../Idle")
