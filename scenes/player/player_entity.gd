class_name PlayerEntity
extends CharacterBody2D

@onready var sprite_2d = $Sprite2D as Sprite2D
#region Handlers Region
@onready var input_handler = $HandlerContainer/InputHandler as InputHandler
@onready var movement_handler = $HandlerContainer/MovementHandler as MovementHandler
@onready var jump_handler = $HandlerContainer/JumpHandler as JumpHandler
@onready var flip_handler = $HandlerContainer/FlipHandler as FlipHandler
@onready var gravity_handler = $HandlerContainer/GravityHandler as GravityHandler
@onready var health_handler = $HandlerContainer/HealthHandler as HealthHandler

@export var animation_player : AnimationPlayer = null

#endregion
#region StateMachine Region
@onready var player_state_machine = $PlayerStateMachine as PlayerStateMachine
@onready var player_idle_state = $PlayerStateMachine/PlayerIdleState as PlayerIdleState
@onready var player_walk_state = $PlayerStateMachine/PlayerWalkState as PlayerWalkState
@onready var player_jump_state = $PlayerStateMachine/PlayerJumpState as PlayerJumpState
@onready var player_fall_state = $PlayerStateMachine/PlayerFallState as PlayerFallState
@onready var player_stomp_state = $PlayerStateMachine/PlayerStompState as PlayerStompState
@onready var player_bounce_state = $PlayerStateMachine/PlayerBounceState as PlayerBounceState

#endregion


func _ready():
	handle_state_machine_signals()
	SignalBus.emit_on_player_ready(self)


func _physics_process(delta):
	gravity_handler.apply_gravity(self, delta)
	move_and_slide()
	flip_handler.handle_flip(self)


func handle_state_machine_signals() -> void:
	player_idle_state.enter_walk_state.connect(player_state_machine.change_state.bind(player_walk_state))
	player_idle_state.enter_jump_state.connect(player_state_machine.change_state.bind(player_jump_state))
	player_walk_state.enter_idle_state.connect(player_state_machine.change_state.bind(player_idle_state))
	player_walk_state.enter_jump_state.connect(player_state_machine.change_state.bind(player_jump_state))
	player_walk_state.enter_fall_state.connect(player_state_machine.change_state.bind(player_fall_state))
	player_jump_state.enter_fall_state.connect(player_state_machine.change_state.bind(player_fall_state))
	player_fall_state.enter_idle_state.connect(player_state_machine.change_state.bind(player_idle_state))
	player_fall_state.enter_stomp_state.connect(player_state_machine.change_state.bind(player_stomp_state))
	player_stomp_state.enter_idle_state.connect(player_state_machine.change_state.bind(player_idle_state))
	player_stomp_state.enter_bounce_state.connect(player_state_machine.change_state.bind(player_bounce_state))
	player_bounce_state.enter_fall_state.connect(player_state_machine.change_state.bind(player_fall_state))
