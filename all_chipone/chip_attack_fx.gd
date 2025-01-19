extends AttackFX

@export var chip_projectile_scene: PackedScene
@export var attack_duration: float = 6

@onready var initial_marker: Marker2D = $InitialMarker
@onready var final_marker: Marker2D = $FinalMarker

var is_attacking := false
var timer := 0.0
var max_time := 0.2

func attack():
	is_attacking = true
	wait_to_stop()


func _process(delta: float) -> void:
	if not is_attacking:
		return
	
	timer += delta
	
	if timer >= max_time:
		timer = 0.0
		spawn_chip()


func spawn_chip():
	var chip_projectile = chip_projectile_scene.instantiate() as Node2D
	
	var random_x = randf_range(initial_marker.global_position.x, final_marker.global_position.x)
	var random_y = randf_range(initial_marker.global_position.y, final_marker.global_position.y)
	
	chip_projectile.global_position = Vector2(random_x, random_y)
	
	get_tree().current_scene.add_child(chip_projectile)


func wait_to_stop():
	await get_tree().create_timer(attack_duration).timeout
	
	is_attacking = false
	ended.emit()
