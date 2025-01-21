class_name PlayerAnimationController
extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


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
