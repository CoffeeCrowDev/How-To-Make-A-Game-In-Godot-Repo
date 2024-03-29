class_name HitboxHandler
extends Area2D

@onready var collision_shape_2d = $CollisionShape2D as CollisionShape2D
@onready var invulberability_timer = $InvulberabilityTimer as Timer
@export var health_handler : HealthHandler = null
@export var invuln_time : float = 0.0

signal on_hit


func _ready():
	on_hit.connect(on_area_hit)
	invulberability_timer.timeout.connect(in_invuln_timer_timeout)


func apply_hit() -> void:
	collision_shape_2d.set_deferred("disabled", true)
	print("Invuln Started")
	invulberability_timer.start(invuln_time)


func on_area_hit() -> void:
	apply_hit()
	print("HIT")
	health_handler.handle_damage(1)



func in_invuln_timer_timeout() -> void:
	collision_shape_2d.disabled = false
	print("Invuln Finished")
