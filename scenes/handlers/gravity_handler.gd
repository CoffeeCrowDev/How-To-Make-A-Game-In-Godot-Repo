class_name GravityHandler
extends Node2D

const GRAVITY : float = 600.0

func apply_gravity(character_body : CharacterBody2D, delta : float) -> void:
	if character_body.is_on_floor() == false:
		character_body.velocity.y += GRAVITY * delta
