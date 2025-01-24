extends ProgressBar

@onready var health_component: HealthComponent = $"../../../HealthComponent"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = health_component.max_health
	value = health_component.max_health
	
	health_component.health_changed.connect(_on_health_changed)


func _on_health_changed(health: float):
	value = health
