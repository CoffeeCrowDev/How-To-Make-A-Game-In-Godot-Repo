class_name DeathHandler
extends Node2D

@export var parent : Node = null
@export_enum("Player", "Enemy") var Type : String = "Player"

func _ready():
	SignalBus.on_level_changed.connect(on_level_changed)


func handle_death() -> void:
	match Type:
		"Player":
			pass
		"Enemy":
			SignalBus.emit_on_enemy_death()
			var drop_handler : DropHandler = null
			
			drop_handler = parent.drop_handler
			
			if drop_handler != null:
				drop_handler.drop_coin()
	
	parent.queue_free()


func on_level_changed() -> void:
	get_parent().get_parent().queue_free()
