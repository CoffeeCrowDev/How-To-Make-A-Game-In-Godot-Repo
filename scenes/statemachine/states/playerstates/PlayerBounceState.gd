class_name  PlayerBounceState
extends PlayerState


signal enter_fall_state


func _ready():
	set_physics_process(false)


func enter_state():
	player_entity.jump_handler.handle_bounce(player_entity, true)
	set_physics_process(true)


func exit_state():
	set_physics_process(false)


func _physics_process(delta):
	player_entity.movement_handler.handle_movement(player_entity, player_entity.input_handler.handle_movement_input(), delta)
	
	if player_entity.velocity.y > 0:
		enter_fall_state.emit()
