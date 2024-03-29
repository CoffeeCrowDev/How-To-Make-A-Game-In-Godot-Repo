class_name PlayerWalkState
extends PlayerState

signal enter_idle_state
signal enter_jump_state
signal enter_fall_state


func _ready():
	set_physics_process(false)


func enter_state() -> void:
	set_physics_process(true)
	player_entity.movement_handler.handle_movement(player_entity, player_entity.input_handler.handle_movement_input(), 0)
	player_entity.animation_player.play("RESET")
	player_entity.animation_player.play("walk")

func exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	player_entity.movement_handler.handle_movement(player_entity, player_entity.input_handler.handle_movement_input(), delta)
	
	if player_entity.input_handler.handle_movement_input() == Vector2.ZERO:
		enter_idle_state.emit()
	
	if player_entity.input_handler.handle_jump_input() == true:
		enter_jump_state.emit()
	
	if player_entity.velocity.y > 0:
		enter_fall_state.emit()
