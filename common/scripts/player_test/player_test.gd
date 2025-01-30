extends Control

const lines: Array[String] = [
	"Hey you!",
	"How are you?",
	"Fine?",
	"Are you ready?",
	"ok! Lets go!",
]
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	call_some_texts()
	
func call_some_texts():
	DialogueManager.start_dialog(lines)
