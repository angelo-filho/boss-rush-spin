class_name AnimationAttackFX
extends AttackFX

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finish)


func attack():
	animation_player.play("attack")


func _on_animation_finish(anim_name: StringName):
	ended.emit()
