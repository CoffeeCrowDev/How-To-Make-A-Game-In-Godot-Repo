extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(on_body_entered)


func on_body_entered(body : Node2D) -> void:
	if body is PlayerEntity:
		SignalBus.emit_on_player_entered_dead_zone()
	
	body.queue_free()
