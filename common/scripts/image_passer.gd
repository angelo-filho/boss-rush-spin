class_name ImagePasser
extends TextureRect

signal passer_finished

@export var images: Array[Texture2D] = []

var image_index := 0
var showing_images := true
var running := false


func _input(event):
	if event.is_action_pressed("ui_accept") and running:
		if showing_images:
			advance_image()


func show_image():
	running = true
	
	if image_index < images.size():
		var image_texture = images[image_index]
		if image_texture:
			texture = image_texture
		else:
			printerr("Erro ao carregar imagem: ", images[image_index])


func advance_image():
	if image_index < images.size():
		image_index += 1
		show_image()
	
	if image_index == images.size():
		passer_finished.emit()
		running = true
