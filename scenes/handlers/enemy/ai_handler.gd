class_name AIHandler
extends Node2D



@export var movement_handler : MovementHandler = null

enum {MOVE_LEFT, MOVE_RIGHT}

var current_state = MOVE_LEFT

func handle_state(character_body : CharacterBody2D, delta : float) -> void:
	check_state()
	
	match current_state:
		
		MOVE_LEFT:
			movement_handler.handle_movement(character_body, Vector2.LEFT, delta)
			
		MOVE_RIGHT:
			movement_handler.handle_movement(character_body, Vector2.RIGHT, delta)


func check_state() -> void:
#	if floor_check_left.is_colliding() == false or wall_check_left.is_colliding():
	#	current_state = MOVE_RIGHT
	
#	if floor_check_right.is_colliding() == false or wall_check_right.is_colliding():
	#	current_state = MOVE_LEFT
	pass


