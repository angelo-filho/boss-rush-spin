extends Control

@onready var label = $TextLabel
@onready var timer = $Timer
@onready var image_display: TextureRect = $ImageTexture
@onready var color_rect: ColorRect = $ColorRect

var texts = [
	"Aren’t you tired of [shake rate=40.0 level=10 connected=1]losing?[/shake]",
	"How about a game?",
	"You have nothing left to lose…"
]

var images = [
	"res://intro Images/first_screen.png",
	"res://intro Images/intro_screen_2.png",
	"res://intro Images/intro_screen_3.png",
	"res://intro Images/intro_screen_4_melhor.png",
	"res://intro Images/intro_screen_5.png"
]

var image_index = 0
var text_index = 0
var showing_images = true
var current_text = ""
var typing = false

@export var typing_speed: float = 0.05
@export var next_scene: String = "res://levels/round_1.tscn"

func _ready():
	color_rect.visible = false
	label.visible = false
	timer.wait_time = typing_speed
	timer.timeout.connect(_show_next_character)
	show_image()

func _input(event):
	if event.is_action_pressed("advance_dialog"):
		if showing_images:
			advance_image()
		elif typing:
			label.visible_characters = -1
			typing = false
			timer.stop()
		else:
			advance_text()

func show_image():
	if image_index < images.size():
		var texture = load(images[image_index])
		if texture:
			image_display.texture = texture
		else:
			print("Erro ao carregar imagem: ", images[image_index])

func advance_image():
	if image_index < images.size() - 1:
		image_index += 1
		show_image()
	else:
		image_display.visible = false  
		showing_images = false
		color_rect.visible = true
		label.visible = true
		start_typing()

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
