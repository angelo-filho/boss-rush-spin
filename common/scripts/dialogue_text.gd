class_name DialogueText
extends RichTextLabel

signal dialogue_finished

@export_multiline var texts: Array[String]
@export var typing_speed: float = 0.05

@onready var timer: Timer = $Timer

var current_text_index: int = 0
var typing = false
var running = false


func _ready() -> void:
	timer.wait_time = typing_speed
	timer.timeout.connect(_on_type_timeout)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and running:
		if typing:
			visible_characters = -1
			typing = false
			timer.stop()
		else:
			next_text()


func start_typing():
	text = texts[current_text_index]
	visible_characters = 0
	typing = true
	running = true
	timer.start()


func next_text():
	if current_text_index < texts.size() - 1:
		current_text_index += 1
		start_typing()
	else:
		dialogue_finished.emit()
		running = false


func _on_type_timeout():
	if visible_characters < text.length():
		visible_characters += 1
	
	if visible_characters == text.length() - 1:
		timer.stop()
		typing = false
