class_name PlayerFallState
extends PlayerState

signal enter_idle_state
signal enter_stomp_state

@export var stomp_transition_point : float = 100.0

func _ready():
	set_physics_process(false)


func enter_state() -> void:
	set_physics_process(true)
	player_entity.animation_player.play("RESET")
	player_entity.animation_player.play("fall")


func exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	player_entity.movement_handler.handle_movement(player_entity, player_entity.input_handler.handle_movement_input(), delta)
	
	if player_entity.is_on_floor() == true:
		enter_idle_state.emit()
	
	if player_entity.velocity.y > stomp_transition_point:
		enter_stomp_state.emit()
