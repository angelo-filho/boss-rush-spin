extends BossState

var attack_fx: AttackFX


func enter(message: Dictionary = {}) -> void:
	if not attack_fx:
		attack_fx = get_child(0)
	
	attack_fx.ended.connect(_on_attack_fx_ended)
	attack_fx.attack()


func exit():
	attack_fx.ended.disconnect(_on_attack_fx_ended)


func _on_attack_fx_ended():
	fsm.change_state($"../Idle")
