extends HBoxContainer

@onready var health_component: HealthComponent = $"../../../HealthComponent"

func _ready() -> void:
	health_component.health_changed.connect(_on_health_changed)


func _on_health_changed(health: float) -> void:
	var health_formatted = int(health)
	
	var hearts = get_children()
	
	for i in hearts.size():
		var heart = hearts[i] as TextureRect
		
		if i + 1 > health and heart.visible:
			animate_heart(heart)


func animate_heart(heart: TextureRect):
	var tween = create_tween().bind_node(heart)
	
	tween.tween_property(heart, "position:x", heart.position.x * 1.4, 0.3)
	tween.parallel()
	tween.tween_property(heart, "modulate:a", 0.0, 0.3)
	
	tween.tween_callback(heart.hide)
