class_name Player
extends CharacterBody2D


@export var speed := 300.0
@export var jump_velocity := -800.0
@export var gravity := 900 
@export var fall_gravity := 2000 

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer

var direction: float

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		coyote_timer.start()

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false

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
