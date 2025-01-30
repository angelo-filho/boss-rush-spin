extends Control

@onready var label = $TextLabel
@onready var timer = $Timer

var texts = [
	"This is the first text being typed...",
	"Now we have a new text on the screen...",
	"[shake rate=20.0 level=5 connected=1]That's it! Moving to the next level...[/shake]"
]

var text_index = 0
var current_text = ""
var typing = false

@export var typing_speed: float = 0.05
@export var next_scene: String = "res://levels/round_1.tscn"

func _ready():
	timer.wait_time = typing_speed
	timer.timeout.connect(_show_next_character)
	start_typing()

func _input(event):
	if event.is_action_pressed("advance_dialog"):
		if typing:
			label.text = current_text
			typing = false
			timer.stop()
		else:
			advance_text()

func start_typing():
	if text_index >= texts.size():
		_change_to_next_scene()
		return

	label.text = texts[text_index]
	label.visible_characters = 0
	typing = true
	timer.start()

func _show_next_character():
	if label.visible_characters < label.text.length():
		label.visible_characters += 1
	else:
		timer.stop()
		typing = false

func advance_text():
	if text_index < texts.size() - 1:
		text_index += 1
		start_typing()
	else:
		_change_to_next_scene()

func _change_to_next_scene():
	get_tree().change_scene_to_file(next_scene)
