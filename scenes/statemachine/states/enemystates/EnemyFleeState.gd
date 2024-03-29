class_name EnemyFleeState
extends EnemyState

func _ready():
	set_physics_process(false)


func enter_state():
	set_physics_process(true)


func exit_state():
	set_physics_process(false)


func _physics_process(delta):
	enemy_entity.movement_handler.handle_movement(enemy_entity, return_to_starting_position(), delta)
	
	if round(enemy_entity.global_position.x) == enemy_entity.starting_location.x:
		SignalBus.emit_on_enemy_fled()
		enemy_entity.queue_free()


func return_to_starting_position() -> Vector2:
	return enemy_entity.global_position.direction_to(enemy_entity.starting_location)
