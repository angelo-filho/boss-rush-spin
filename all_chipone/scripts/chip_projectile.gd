extends Node2D

@export var speed: float = 500


func _ready() -> void:
	wait_to_die()


func _process(delta: float) -> void:
	global_position += Vector2.DOWN * speed * delta


func wait_to_die():
	await get_tree().create_timer(3.0).timeout
