class_name PatrollerEnemy
extends CharacterBody2D

#region Handlers
@onready var movement_handler = $HandlerContainer/MovementHandler as MovementHandler
@onready var flip_handler = $HandlerContainer/FlipHandler as FlipHandler
@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var gravity_handler = $HandlerContainer/GravityHandler as GravityHandler
@onready var hurtbox_handler = $HandlerContainer/HurtboxHandler as HurtboxHandler
@onready var drop_handler = $HandlerContainer/Drop_Handler as DropHandler
#endregion

#region Variables
@export var floor_check_left : RayCast2D = null
@export var floor_check_right : RayCast2D = null
@export var wall_check_left : RayCast2D = null
@export var wall_check_right : RayCast2D = null
#endregion

#region StateMachine
@onready var enemy_state_machine = $EnemyStateMachine as EnemyStateMachine
@onready var enemy_wander_state = $EnemyStateMachine/EnemyWanderState as EnemyWanderState
@onready var enemy_flee_state = $EnemyStateMachine/EnemyFleeState as EnemyFleeState
#endregion


var starting_location : Vector2 = Vector2.ZERO


func _ready():
	handle_state_machine_signals()
	hurtbox_handler.area_entered.connect(on_player_hit)


func _physics_process(delta):
	gravity_handler.apply_gravity(self, delta)
	
	move_and_slide()
	
	flip_handler.handle_flip(self)


func on_player_hit(area : Area2D) -> void:
	drop_handler.add_coin(1)


func handle_state_machine_signals() -> void:
	enemy_wander_state.enter_flee_state.connect(enemy_state_machine.change_state.bind(enemy_flee_state))
