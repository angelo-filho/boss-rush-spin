class_name OneTimeHurtBox
extends Area2D


@export var damage: float = 1

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	var health = body.get_node("HealthComponent") as HealthComponent
	
	health.receive_damage(damage)
	
	get_parent().queue_free()
