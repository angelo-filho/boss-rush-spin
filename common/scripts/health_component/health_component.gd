class_name HealthComponent
extends Node2D

signal health_changed(current_health: float)
signal damage_received
signal health_added
signal died

@export var max_health: float

var is_dead: bool:
	get:
		return health <= 0

var health: float


func _ready() -> void:
	health = max_health


func receive_damage(damage: float) -> void:
	if is_dead:
		return
	
	health = max(health - damage, 0)
	
	health_changed.emit(health)
	damage_received.emit()
	
	if health == 0:
		died.emit()


func add_health(value: float):
	health = clamp(value, 0.0, max_health)
	health_changed.emit(health)
	health_added.emit()
