extends AttackFX

@export var amount: int = 3
@export var spawn_delay: float = 0.2
@export var wait_delay: float = 0.5
@export var clover_scene: PackedScene
@export var places: Array[Marker2D]
@export var player: Node2D

var clovers_destroyed := 0


func _ready() -> void:
	if not player:
		player = get_tree().get_first_node_in_group("player")


func attack():
	spawn_clovers()


func spawn_clovers():
	for i in range(amount):
		var clover = clover_scene.instantiate() as CloverMissile
		
		clover.global_position = places[i].global_position
		clover.target = player
		clover.wait_delay = i * wait_delay
		
		get_tree().current_scene.add_child(clover)
		clover.tree_exited.connect(_on_clove_destroyed)
		
		if i != amount - 1:
			await get_tree().create_timer(spawn_delay).timeout


func _on_clove_destroyed():
	clovers_destroyed += 1
	
	if clovers_destroyed == amount:
		clovers_destroyed = 0
		
		ended.emit()
