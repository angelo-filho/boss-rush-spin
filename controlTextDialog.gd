class_name StartCutscene
extends Control

@onready var image_passer: ImagePasser = $ImagePasser
@onready var dialogue_text: DialogueText = $DialogueText
@onready var scene_7: ImagePasser = $Scene7
@onready var curtains: AnimatedSprite2D = $Curtains
@onready var curtains_dialogue: DialogueText = $CurtainsDialogue

func play() -> void:
	image_passer.show_image()
	
	image_passer.passer_finished.connect(_on_passer_finished)


func _on_passer_finished():
	image_passer.passer_finished.disconnect(_on_passer_finished)
	image_passer.visible = false
	dialogue_text.start_typing.call_deferred()
	dialogue_text.dialogue_finished.connect(_on_fist_dialogue_finished)


func _on_fist_dialogue_finished():
	dialogue_text.dialogue_finished.disconnect(_on_fist_dialogue_finished)
	scene_7.visible = true
	scene_7.show_image.call_deferred()
	scene_7.passer_finished.connect(_on_scenete_7_finished)


func _on_scenete_7_finished():
	scene_7.passer_finished.disconnect(_on_scenete_7_finished)
	
	curtains.play("close")
	
	await curtains.animation_finished
	
	curtains_dialogue.show()
	curtains_dialogue.start_typing()
	
	curtains_dialogue.dialogue_finished.connect(func(): get_tree().change_scene_to_file("res://levels/round_1.tscn"))
