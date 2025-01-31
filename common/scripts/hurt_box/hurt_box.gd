class_name HurtBox
extends Area2D

@export var damage: float = 1

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if not body is Player:
			continue
		
		var health = body.get_node("HealthComponent") as HealthComponent
		
		health.receive_damage(damage)
