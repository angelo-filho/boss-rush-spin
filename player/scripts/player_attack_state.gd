extends PlayerState

@export var speed: float = 300
@export var attack_duration: float = 0.3
@onready var collision_shape_2d: CollisionShape2D = $"../../AttackArea/CollisionShape2D"

var attack_count = 0

func enter(message: Dictionary = {}) -> void:
	collision_shape_2d.disabled = false
	core.animation_controller.play_attack(randi_range(1, 2))
	
	attack_count += 1
	
	if attack_count == 2:
		attack_count = 0
	
	core.velocity = Vector2.ZERO
	
	wait_to_change_state()


func exit():
	collision_shape_2d.disabled = true


func wait_to_change_state():
	await get_tree().create_timer(attack_duration).timeout
	
	fsm.change_state($"../Idle")
