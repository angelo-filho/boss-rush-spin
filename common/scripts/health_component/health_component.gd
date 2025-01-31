class_name HealthComponent
extends Node2D

signal health_changed(current_health: float)
signal damage_received
signal health_added
signal died

@export var max_health: float
@export var invecible_duration: float = 0.0

var is_invecible: bool = false
var is_dead: bool:
	get:
		return health <= 0

var health: float


func _ready() -> void:
	health = max_health


func receive_damage(damage: float) -> void:
	if is_dead or is_invecible:
		return
	
	health = max(health - damage, 0)
	
	health_changed.emit(health)
	damage_received.emit()
	
	if invecible_duration > 0.0:
		is_invecible = true
		get_tree().create_timer(invecible_duration).timeout.connect(func(): is_invecible = false)
	
	if health == 0:
		died.emit()


func add_health(value: float):
	health = clamp(value, 0.0, max_health)
	health_changed.emit(health)
	health_added.emit()
