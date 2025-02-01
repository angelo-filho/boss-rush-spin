extends Node2D

@onready var left_arm_wheel: Wheel = $LeftArmWheel
@onready var head_wheel: Wheel = $HeadWheel
@onready var right_arm_wheel: Wheel = $RightArmWheel
@onready var boss: Boss = $"../BossBase"


var boss_data: BossData

func _ready() -> void:
	boss_data = BossData.new()
	
	left_arm_wheel.spin()
	right_arm_wheel.spin()
	head_wheel.spin()
	
	left_arm_wheel.spin_end.connect(_on_left_wheel_spin_end)
	right_arm_wheel.spin_end.connect(_on_right_wheel_spin_end)
	head_wheel.spin_end.connect(_on_head_wheel_spin_end)


func hide_wheels():
	hide()
	hide_wheel(left_arm_wheel)
	hide_wheel(right_arm_wheel)
	hide_wheel(head_wheel)


func hide_wheel(wheel: Node):
	wheel.hide()
	wheel.process_mode = Node.PROCESS_MODE_DISABLED

func _on_left_wheel_spin_end(piece: WheelPiece):
	boss_data.left_arm = piece


func _on_right_wheel_spin_end(piece: WheelPiece):
	boss_data.right_arm = piece

func _on_head_wheel_spin_end(piece: WheelPiece):
	boss_data.head = piece
	
	var curtains = $"../CurtainsLayer/Curtains" as AnimatedSprite2D
	
	curtains.play("close")
	
	await curtains.animation_finished	
	
	hide_wheels()
	
	boss.setup(boss_data)
	
	await get_tree().create_timer(0.2).timeout
	
	curtains.play("open")
