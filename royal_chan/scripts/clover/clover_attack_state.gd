extends CloverState

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO


func enter(message: Dictionary = {}) -> void:
	wait_to_die()


func physics_tick(delta: float) -> void:
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(core.speed)
	
	core.global_position += velocity * delta


func seek():
	var steer := Vector2.ZERO
	
	if core.target:
		var desired = (core.target.position - core.position).normalized() * core.speed
		steer = (desired - velocity).normalized() * core.steer_force
	
	return steer


func wait_to_die():
	await get_tree().create_timer(core.life_time).timeout
	
	core.queue_free()
