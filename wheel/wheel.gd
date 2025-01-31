class_name Wheel
extends Control

signal spin_end(piece: WheelPiece)

@export var pieces: Array[WheelPiece]
@export var wheel: TextureRect
@export var angle_offset: float
@export var spin_duration: float
@export var wheel_line_scene: PackedScene
@export var wheel_piece_icon_scene: PackedScene

@onready var wheel_sound: AudioStreamPlayer = $WheelSound
@onready var animation_player: AnimationPlayer = $WheelPicker/Pointer/AnimationPlayer
@onready var pointer: TextureRect = $WheelPicker/Pointer

var piece_angle: float
var half_piece_angle: float
var is_spinning: bool

var prev_angle: float
var current_angle: float
var is_indicator_on_the_line: bool

var pointer_tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	piece_angle = 360.0 / pieces.size()
	half_piece_angle = piece_angle / 2.0
	
	setup_pieces()


func _process(delta: float) -> void:
	if OS.is_debug_build() and not is_spinning and Input.is_action_just_pressed("ui_accept"):
		spin()


func setup_pieces():
	for i in pieces.size():
		var data = pieces[i]
		var piece = wheel_piece_icon_scene.instantiate() as TextureRect
		
		piece.texture = data.icon
		
		wheel.add_child(piece)
		
		var wheel_center = wheel.pivot_offset - piece.pivot_offset
		var wheel_radius_rotated = Vector2.from_angle(deg_to_rad(piece_angle * i - 90)) * (wheel.size / 4)
		piece.position = wheel_center + wheel_radius_rotated
		
		piece.rotation = deg_to_rad(piece_angle * i)
		
		var wheel_line: Line2D = wheel_line_scene.instantiate()
		
		var line_angle = Vector2.from_angle(deg_to_rad(piece_angle * i - 90 + half_piece_angle)) * (wheel.size / 2)
		
		wheel_line.clear_points()
		
		wheel_line.add_point(wheel.pivot_offset)
		wheel_line.add_point(wheel.pivot_offset + line_angle)
		
		wheel.add_child(wheel_line)


func spin():
	if is_spinning:
		return
	
	is_spinning = true
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_QUAD)
	
	var index = randi_range(0, pieces.size() - 1)
	
	var angle = -int(index * piece_angle)
	var left_offset = (angle - int(half_piece_angle)) % 360
	var right_offset = (angle + int(half_piece_angle)) % 360
	
	var random_angle = randi_range(left_offset, right_offset)
	
	var target_rotation = random_angle + 2 * 360 * spin_duration
	#var back_angle = angle - random_angle
	
	prev_angle = wheel.rotation_degrees
	current_angle = wheel.rotation_degrees
	
	is_indicator_on_the_line = false
	
	tween.tween_property(wheel, "rotation_degrees", target_rotation, spin_duration)
	tween.parallel()
	tween.tween_method(func(degress: float):
		var diff = abs(prev_angle - current_angle)
		
		if diff >= half_piece_angle:
			if is_indicator_on_the_line:
				animated_pointer()
				wheel_sound.play()
			
			prev_angle = current_angle
			is_indicator_on_the_line = !is_indicator_on_the_line
		
		current_angle = degress
		, wheel.rotation_degrees, target_rotation, spin_duration)
	
	tween.finished.connect(func(): _on_spin_finished(index))


func animated_pointer():
	if pointer_tween:
		pointer_tween.kill()
	
	pointer_tween = create_tween()

	pointer_tween.tween_property(pointer, "rotation_degrees", 202, 0.05)
	pointer_tween.tween_property(pointer, "rotation_degrees", 180, 0.05)


func _on_spin_finished(piece_index: int):
	var piece = pieces[piece_index]
	is_spinning = false
	wheel.rotation_degrees = int(wheel.rotation_degrees) % 360
	spin_end.emit(piece)
