extends PlayerState

func enter(message: Dictionary = {}) -> void:
	core.animation_controller.play_death()
	core.velocity = Vector2.ZERO
