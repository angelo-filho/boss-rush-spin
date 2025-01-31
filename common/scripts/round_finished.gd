extends Node2D

@export_file var scene_to_go: String

@onready var animation_player: AnimationPlayer = $CanvasLayer/Control/ColorRect/AnimationPlayer

func _ready() -> void:
	EventBus.boss_died.connect(_on_boss_died)


func _on_boss_died():
	await get_tree().create_timer(1.0).timeout
	
	animation_player.play("fade_out")
	
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file(scene_to_go)
