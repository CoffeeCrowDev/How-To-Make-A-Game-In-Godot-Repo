class_name EnemyStateMachine
extends FiniteStateMachine

@export var enemy_entity : PatrollerEnemy = null

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
		if i is EnemyState:
			i.enemy_entity = enemy_entity
