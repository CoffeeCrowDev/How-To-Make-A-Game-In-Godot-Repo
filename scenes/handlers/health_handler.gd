class_name HealthHandler
extends Node2D


@export var starting_health : int = 0
@export var death_handler : DeathHandler = null
@export_enum("Player", "Enemy") var Type : String = "Player"


var max_health : int = 0
var current_health : int = 0


func _ready():
	set_max_health()


func set_max_health() -> void:
	max_health = starting_health
	current_health = max_health
	if Type == "Player":
		max_health = GlobalStatContainer.get_current_coins()
		current_health = max_health


func handle_damage(value : int) -> void:
	match Type:
		"Player":
			SignalBus.emit_on_hit(1)
			current_health -= value
		"Enemy":
			current_health -= value
	
	
	if current_health <= 0:
		current_health = 0
		death_handler.handle_death()


func handle_healing(value : int) -> void:
	current_health += value
