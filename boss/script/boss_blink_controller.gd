extends Node2D

@export var duration := 0.3
@export var cd := 0.3

@onready var health_component: HealthComponent = $"../HealthComponent"
@onready var body_parts: Node2D = $"../BodyParts"

var timer: SceneTreeTimer

func _ready() -> void:
	health_component.damage_received.connect(_on_damage_received)


func _on_damage_received():
	if timer and timer.time_left > 0:
		return
	
	timer = get_tree().create_timer(cd)
	
	var tween = create_tween()
	
	var step_duration = duration / 2.0
	
	tween.tween_property(body_parts, "modulate:s", 0.3, step_duration)
	tween.tween_property(body_parts, "modulate:s", 0.0, step_duration)
