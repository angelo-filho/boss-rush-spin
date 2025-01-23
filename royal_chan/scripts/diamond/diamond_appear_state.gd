extends DiamondState

func enter(message: Dictionary = {}) -> void:
	grow_up()

func grow_up():
	var tween = create_tween()
	
	tween.tween_property(core, "global_scale", Vector2(1.2, 1.2), .2).from(Vector2.ZERO)
	tween.tween_property(core, "global_scale", Vector2(1.0, 1.0), .1)
	
	await tween.finished
	
	await get_tree().create_timer(0.7).timeout
	
	fsm.change_state($"../Wait")
