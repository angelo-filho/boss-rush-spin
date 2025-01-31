extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/dialogue_scene.tscn")
	pass


func _on_options_button_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()
