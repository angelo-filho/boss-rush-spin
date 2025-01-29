class_name JackpotAttackFX
extends AttackFX

@export var attack_fxs: Array[PackedScene] = []

var current_attack: AttackFX

func attack():
	current_attack = attack_fxs.pick_random().instantiate() as AttackFX
	
	get_tree().current_scene.add_child(current_attack)
	
	current_attack.attack.call_deferred()
	current_attack.ended.connect(_on_ended)


func _on_ended():
	self.ended.emit()
	current_attack.queue_free()
	
