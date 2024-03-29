class_name JumpHandler
extends Node2D

@export var jump_speed : float = 300.0
@export var bounce_speed : float = 200.0


func handle_jump(character_body : CharacterBody2D, is_jumping : bool) -> void:
	if is_jumping and character_body.is_on_floor():
		character_body.velocity.y = -jump_speed


func handle_bounce(character_body : CharacterBody2D, is_bouncing : bool) -> void:
	if is_bouncing:
		character_body.velocity.y = -bounce_speed
