class_name Boss
extends Node2D

@export var boss_data: BossData

@onready var finite_state: FSM = $FiniteState
@onready var body_parts: Node2D = $BodyParts

var setuped := false


func setup(boss_data: BossData):
	setuped = true
	setup_fx(boss_data)
	setup_body_parts(boss_data)


func setup_fx(boss_data: BossData):
	finite_state.get_node("HeadAttack").add_child(boss_data.head.fx.instantiate())
	finite_state.get_node("ArmLeftAttack").add_child(boss_data.left_arm.fx.instantiate())
	finite_state.get_node("ArmRightAttack").add_child(boss_data.right_arm.fx.instantiate())


func setup_body_parts(boss_data: BossData):
	body_parts.get_node("Head").sprite_frames = boss_data.head.part_sprites[0]
	body_parts.get_node("Torso").sprite_frames = boss_data.head.part_sprites[1]
	body_parts.get_node("RightArm").sprite_frames = boss_data.right_arm.part_sprites[0]
	body_parts.get_node("LeftArm").sprite_frames = boss_data.left_arm.part_sprites[0]
