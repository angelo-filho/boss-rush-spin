extends Node2D

@onready var finite_state: FSM = $FiniteState
@onready var health_component: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $CanvasLayer/Control/HealthBar
@onready var hit_box: Area2D = $HitBox

var setuped = true

func _ready() -> void:
	health_component.died.connect(_on_died)


func _on_died():
	EventBus.boss_died.emit()
	$DeathParticle.emitting = true
	
	await get_tree().create_timer(3.0).timeout
	
	get_tree().change_scene_to_file.call_deferred("res://levels/game_over.tscn")
