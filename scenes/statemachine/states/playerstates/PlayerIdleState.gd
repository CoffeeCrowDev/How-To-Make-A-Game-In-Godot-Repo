class_name PlayerIdleState
extends PlayerState

signal enter_walk_state
signal enter_jump_state


func _ready():
	set_physics_process(false)


func enter_state() -> void:
	set_physics_process(true)
	player_entity.animation_player.play("RESET")
	player_entity.animation_player.play("idle")


func exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	player_entity.movement_handler.handle_deceleration(player_entity, delta)
	
	if player_entity.input_handler.handle_movement_input() != Vector2.ZERO:
		enter_walk_state.emit()
	
	if player_entity.input_handler.handle_jump_input() == true:
		enter_jump_state.emit()
