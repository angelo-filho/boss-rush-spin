extends CanvasLayer

func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/player_test.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
