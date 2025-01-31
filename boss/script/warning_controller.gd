class_name BossWarning
extends Node2D

signal finished

enum POINTS {
	LEFT = 0,
	MIDDLE = 1,
	RIGHT = 2
}

@onready var warning: Sprite2D = $Warning
@onready var left_point: Marker2D = $Points/LeftPoint
@onready var middle_point: Marker2D = $Points/MiddlePoint
@onready var right_point: Marker2D = $Points/RightPoint

var points: Array[Marker2D] = []

func _ready() -> void:
	points.append_array([left_point, middle_point, right_point])
	
	warning.hide()


func show_warning(point: POINTS) -> void:
	var position_desired = points[point].global_position
	
	warning.global_position = position_desired
	warning.show()
	
	var tween = create_tween()
	
	tween.set_loops(2)
	
	tween.tween_property(warning, "modulate:a", 0.0, 0.2)
	tween.tween_property(warning, "modulate:a", 1.0, 0.2)
	
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished():
	finished.emit()
	warning.hide()
