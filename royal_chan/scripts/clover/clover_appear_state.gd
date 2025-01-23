extends CloverState

@export var duration := 2.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter(message: Dictionary = {}) -> void:
	animation_player.play("appear")
	wait_to_change()


func wait_to_change():
	await get_tree().create_timer(duration + core.wait_delay).timeout
	
	fsm.change_state($"../Attack")
