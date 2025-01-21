class_name Player
extends CharacterBody2D


@export var speed := 300.0
@export var jump_velocity := -800.0
@export var gravity := 900
@export var fall_gravity := 2000 

@onready var coyote_timer: Timer = $CoyoteTimer
@onready var animation_controller: PlayerAnimationController = $AnimationController
@onready var attack_area: Area2D = $AttackArea
@onready var right_attack_marker: Marker2D = $RightAttackMarker
@onready var left_attack_marker: Marker2D = $LeftAttackMarker

var direction: float
var last_direction: float = 1.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		coyote_timer.start()
	
	if event.is_action_pressed("ui_down") and is_on_floor():
		position.y += 1

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	
	if abs(direction) > 0:
		last_direction = direction
	
	if direction < 0:
		attack_area.position = left_attack_marker.position
		animation_controller.animated_sprite_2d.flip_h = true
	elif direction > 0:
		attack_area.position = right_attack_marker.position
		animation_controller.animated_sprite_2d.flip_h = false

	move_and_slide()


func move_horizontaly():
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func can_jump() -> bool:
	return not coyote_timer.is_stopped() and is_on_floor()


func jump():
	coyote_timer.stop()
	velocity.y = jump_velocity
