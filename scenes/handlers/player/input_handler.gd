class_name InputHandler
extends Node2D



func handle_movement_input() -> Vector2:
	var movement_direction : Vector2 = Vector2.ZERO
	
	movement_direction.x = Input.get_axis("move_left", "move_right")
	
	return movement_direction


func handle_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")
