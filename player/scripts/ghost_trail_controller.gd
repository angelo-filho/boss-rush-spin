class_name GhostTrailController
extends Node2D

@export var amount: int = 5
@export var trail_scene: PackedScene

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimationController/AnimatedSprite2D"


func play_ghost_trail(duration: float):
	var spawn_gap := duration / amount
	
	spawn_ghost_trail()
	
	for i in amount - 1:
		await get_tree().create_timer(spawn_gap).timeout
		spawn_ghost_trail()


func spawn_ghost_trail():
	var trail = trail_scene.instantiate() as Sprite2D
	
	trail.texture = animated_sprite_2d\
		.sprite_frames\
		.get_frame_texture(animated_sprite_2d.animation, animated_sprite_2d.frame)
	
	trail.flip_h = animated_sprite_2d.flip_h
	trail.offset = animated_sprite_2d.offset
	
	trail.global_position = global_position
	
	get_tree().current_scene.add_child(trail)
