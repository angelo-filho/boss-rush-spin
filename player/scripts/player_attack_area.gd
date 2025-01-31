extends Area2D

@export var damage := 20

@onready var hit_particles: GPUParticles2D = $"../HitParticles"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_shape_entered.connect(on_area_shape_entered)


func on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	$"../SFXs/Hit".play()
	var healt_component = area.get_parent().get_node_or_null("HealthComponent") as HealthComponent
	
	if healt_component:
		healt_component.receive_damage(damage)

	hit_particles.global_position = global_position
	hit_particles.restart()
