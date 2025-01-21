extends State

var attack_fx: AttackFX


func _ready() -> void:
	attack_fx = get_child(0)


func enter(message: Dictionary = {}) -> void:
	attack_fx.ended.connect(_on_attack_fx_ended)
	attack_fx.attack()


func exit():
	attack_fx.ended.disconnect(_on_attack_fx_ended)


func _on_attack_fx_ended():
	fsm.change_state($"../Idle")
