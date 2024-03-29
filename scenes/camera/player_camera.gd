class_name PlayerCamera
extends Camera2D

@export_range(0.0, 10) var camera_follow_speed : float
@export var camera_offset_vector : Vector2 = Vector2.ZERO


var player : PlayerEntity = null

func _ready():
	SignalBus.on_player_ready.connect(set_target)


func _physics_process(delta):
	follow_target(delta)


func set_target(target : PlayerEntity) -> void:
	if target == null:
		return
	
	player = target


func follow_target(delta : float) -> void:
	if player == null:
		return
	
	position = lerp(position, player.position + camera_offset_vector, camera_follow_speed * delta)
