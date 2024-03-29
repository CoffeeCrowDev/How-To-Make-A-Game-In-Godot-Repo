class_name FlipHandler
extends Node2D


func handle_flip(character_body : CharacterBody2D) -> void:
	if character_body.velocity.x < 0:
		character_body.sprite_2d.flip_h = false
	
	if character_body.velocity.x > 0:
		character_body.sprite_2d.flip_h = true
