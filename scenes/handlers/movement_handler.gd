class_name MovementHandler
extends Node2D


@export var movement_speed : float = 0.0
@export var acceleration : float = 0.0
@export var deceleration : float = 0.0


func handle_movement(character_body : CharacterBody2D, input_dir : Vector2, delta : float) -> void:
	if input_dir.x < 0:
		character_body.velocity.x = lerp(character_body.velocity.x, -movement_speed, acceleration * delta)
		return
	
	if input_dir.x > 0:
		character_body.velocity.x = lerp(character_body.velocity.x, movement_speed, acceleration * delta)
		return
	
	handle_deceleration(character_body, delta)


func handle_deceleration(character_body : CharacterBody2D, delta : float) -> void:
	character_body.velocity.x = lerp(character_body.velocity.x, 0.0, deceleration * delta)

