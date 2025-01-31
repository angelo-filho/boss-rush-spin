class_name CloverMissile
extends Node2D

@export var speed := 350.0
@export var steer_force := 50.0
@export var life_time: float = 4.0
@export var target: Node2D

var wait_delay := 0.0
