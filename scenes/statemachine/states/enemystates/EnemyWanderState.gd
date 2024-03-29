class_name EnemyWanderState
extends EnemyState

signal enter_flee_state

@export var flee_timer : Timer = null
var moving_left : bool = false


func _ready():
	flee_timer.timeout.connect(on_flee_timer_timeout)
	set_physics_process(false)


func enter_state():
	set_physics_process(true)
	flee_timer.start(NodeExtensions.get_random_time(10.0,20.0))


func exit_state():
	set_physics_process(false)


func _physics_process(delta):
	if enemy_entity.floor_check_left.is_colliding() == false or enemy_entity.wall_check_left.is_colliding():
		moving_left = false
	
	if enemy_entity.floor_check_right.is_colliding() == false or enemy_entity.wall_check_right.is_colliding():
		moving_left = true
	
	match moving_left:
		false:
			enemy_entity.movement_handler.handle_movement(enemy_entity, Vector2.RIGHT, delta)
		
		true:
			enemy_entity.movement_handler.handle_movement(enemy_entity, Vector2.LEFT, delta)
	
	if enemy_entity.drop_handler.current_coin_count > 0:
		enter_flee_state.emit()


func on_flee_timer_timeout() -> void:
	enter_flee_state.emit()
