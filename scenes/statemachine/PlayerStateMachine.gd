class_name PlayerStateMachine
extends FiniteStateMachine

@export var player_entity : PlayerEntity = null

func _ready():
	set_children()
	change_state(current_state)


func change_state(new_state : State) -> void:
	if current_state is State:
		current_state.exit_state()
	
	new_state.enter_state()
	current_state = new_state


func set_children() -> void:
	for i in get_children():
		if i is PlayerState:
			i.player_entity = player_entity
