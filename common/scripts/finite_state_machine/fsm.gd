class_name FSM
extends Node2D

@export var current_state: State

func _ready() -> void:
	prepare.call_deferred()

func _input(event: InputEvent) -> void:
	current_state.input_tick(event)

func _process(delta: float) -> void:
	current_state.tick(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_tick(delta)

func prepare():
	var parent = get_parent()
	for state in get_children():
		state.fsm = self
		state.core = parent
	
	current_state.enter()

func change_state(newState: State, msg: Dictionary = {}):
	current_state.exit()
	current_state = newState
	current_state.enter(msg)
