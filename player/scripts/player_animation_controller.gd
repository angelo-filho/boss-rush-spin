class_name PlayerAnimationController
extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var tween: Tween


func play_idle():
	animation_player.play("idle")


func play_run():
	animation_player.play("run")


func play_attack(number: int):
	animation_player.play("attack_" + str(number))


func play_jump():
	animation_player.play("jump")


func play_fall():
	animation_player.play("fall")


func play_dash():
	animation_player.play("dash")


func play_death():
	animation_player.play("death")


func play_blink():
	if tween:
		tween.kill()
	
	tween = create_tween().set_loops(3)
	
	tween.tween_property(self, "modulate:a", 0, 0.1).from(1.0)
	tween.tween_property(self, "modulate:a", 1.0, 0.1).from(0.0)
