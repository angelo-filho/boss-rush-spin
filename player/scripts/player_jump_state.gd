extends PlayerState

@onready var jump_dust: GPUParticles2D = $"../../JumpDust"
@onready var jump_trail: GPUParticles2D = $"../../JumpTrail"

func enter(message: Dictionary = { "can_jump": false }) -> void:
	if message["can_jump"]:
		core.animation_controller.play_jump()
		core.jump()
		jump_dust.restart()
		jump_trail.restart()
		get_tree().create_timer(0.1).timeout.connect(func(): jump_trail.emitting = false)


func physics_tick(delta: float) -> void:
	if core.is_on_floor():
		fsm.change_state($"../Idle")
		
		return
	
	if Input.is_action_just_pressed("dash"):
		fsm.change_state($"../Dash")
		
		return
	
	if Input.is_action_just_pressed("dash"):
		fsm.change_state($"../Dash")
		
		return
	
	
	if Input.is_action_just_released("jump") and core.velocity.y < 0:
		core.velocity.y = core.velocity.y / 2.5
	
	if core.velocity.y > 0:
		core.animation_controller.play_fall()
	
	
	core.velocity += Vector2(0, get_gravity()) * delta
	
	core.move_horizontaly()


func exit() -> void:
	core.velocity = Vector2.ZERO


func get_gravity():
	if core.velocity.y < 0:
		return core.gravity
	
	return core.fall_gravity
