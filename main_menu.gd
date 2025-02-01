extends Control

func _ready() -> void:
	$VBoxContainer/PlayButton.grab_focus()

func _on_play_button_pressed() -> void:
	$VBoxContainer/PlayButton.release_focus()
	
	$AnimationPlayer.play("start")
	
	await $AnimationPlayer.animation_finished
	
	$Cutscene.play()


func _on_options_button_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()
