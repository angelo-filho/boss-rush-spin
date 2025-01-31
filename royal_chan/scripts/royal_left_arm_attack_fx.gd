extends AttackFX

@export var diamond_scene: PackedScene
@export var amount: int = 3
@export var spawn_delay: float = 0.2
@export var wait_delay: float = 0.5
@export var distance: float = 60
@export var max_attacks: int = 3
@export var player: Node2D

@onready var right_spawn_marker: Marker2D = $RightSpawnMarker
@onready var left_spawn_marker: Marker2D = $LeftSpawnMarker

var attack_count := 0

func _ready() -> void:
	if not player:
		player = get_tree().get_first_node_in_group("player")

func attack():
	spawn_diamonds()


func spawn_diamonds():
	for i in range(amount):
		create_diamond_duo(left_spawn_marker.global_position + Vector2(i * distance, i * -distance), i)
		var right_diamond = create_diamond_duo(right_spawn_marker.global_position + Vector2(i * -distance, i * -distance), i)
		
		if i != amount - 1:
			await get_tree().create_timer(spawn_delay).timeout
		
		if i == amount - 1:
			right_diamond.went.connect(_on_last_diamond_went)


func create_diamond_duo(spawn_position: Vector2, index: int):
	var diamond = diamond_scene.instantiate() as Diamond
		
	diamond.global_position = spawn_position
	diamond.player = player
	
	diamond.wait_delay = wait_delay * index
	
	get_tree().current_scene.add_child(diamond)
	
	return diamond


func _on_last_diamond_went():
	attack_count += 1
	
	if attack_count >= max_attacks:
		attack_count = 0
		
		ended.emit()
		
		return
	
	spawn_diamonds()
