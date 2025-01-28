class_name Boss
extends Node2D

@export var boss_data: BossData

@onready var finite_state: FSM = $FiniteState
@onready var body_parts: Node2D = $BodyParts
@onready var health_component: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $CanvasLayer/Control/HealthBar
@onready var hit_box: Area2D = $HitBox

var setuped := false


func _ready() -> void:
	hit_box.process_mode = Node.PROCESS_MODE_DISABLED
	health_bar.hide()
	health_component.died.connect(func(): get_tree().change_scene_to_file.call_deferred("res://levels/game_over.tscn"))


func setup(boss_data: BossData):
	setuped = true
	setup_fx(boss_data)
	setup_body_parts(boss_data)
	health_bar.show()
	hit_box.process_mode = Node.PROCESS_MODE_INHERIT


func setup_fx(boss_data: BossData):
	finite_state.get_node("HeadAttack").add_child(boss_data.head.fx.instantiate())
	finite_state.get_node("ArmLeftAttack").add_child(boss_data.left_arm.fx.instantiate())
	finite_state.get_node("ArmRightAttack").add_child(boss_data.right_arm.fx.instantiate())


func setup_body_parts(boss_data: BossData):
	body_parts.get_node("Head").sprite_frames = boss_data.head.part_sprites[0]
	body_parts.get_node("Torso").sprite_frames = boss_data.head.part_sprites[1]
	body_parts.get_node("RightArm").sprite_frames = boss_data.right_arm.part_sprites[0]
	body_parts.get_node("LeftArm").sprite_frames = boss_data.left_arm.part_sprites[0]
