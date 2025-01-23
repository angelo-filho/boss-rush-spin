extends AttackFX

@export var positions: Array[Marker2D]
@export var cards: Array[CardSprite]
@export var spade_scene: PackedScene

@onready var cards_node: Node2D = $Cards


func _ready() -> void:
	cards_node.hide()


func attack():
	spawn_cards()


func spawn_cards():
	cards_node.show()
	
	cards.shuffle()
	
	for i in cards.size():
		var card = cards[i]
		
		card.global_position = positions[i].global_position
		card.slide_in_down()
		
		if i != cards.size() - 1:
			await get_tree().create_timer(0.1).timeout
	
	wait_to_attack()


func spawn_spades():
	for i in cards.size():
		if cards[i].name == "HeartCard":
			continue
		
		var spade = spade_scene.instantiate() as Node2D
		
		spade.global_position.x = positions[i].global_position.x
		spade.global_position.y = -400
		
		get_tree().current_scene.add_child(spade)
		


func wait_to_attack():
	await get_tree().create_timer(4.0).timeout
	
	for i in cards.size():
		var card = cards[i]
		
		card.exit_anim()
		
		if i != cards.size() - 1:
			await get_tree().create_timer(0.1).timeout
	
	spawn_spades()
	
	await get_tree().create_timer(3).timeout
	
	ended.emit()
