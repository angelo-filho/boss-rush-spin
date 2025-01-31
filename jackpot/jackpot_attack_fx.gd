class_name JackpotAttackFX
extends AttackFX

enum BodyPart {
	HEAD,
	LEFT_ARM,
	RIGHT_ARM
}

@export var wheel: Wheel
@export var body_part: BodyPart

var current_attack: AttackFX

func attack() -> void:
	wheel.spin()
	wheel.spin_end.connect(_on_spin_ended)


func _on_spin_ended(piece: WheelPiece) -> void:
	current_attack = piece.fx.instantiate() as AttackFX
	
	get_tree().current_scene.add_child(current_attack)
	
	current_attack.attack.call_deferred()
	current_attack.ended.connect(_on_ended)
	
	wheel.spin_end.disconnect(_on_spin_ended)


func _on_ended() -> void:
	self.ended.emit()
	current_attack.queue_free()
	
