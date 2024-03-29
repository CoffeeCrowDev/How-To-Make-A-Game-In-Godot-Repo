class_name CollectableManager
extends Node

var current_coins_collected : int = 0

func _ready():
	if GlobalStatContainer.get_current_coins() != 0:
		current_coins_collected = GlobalStatContainer.get_current_coins()
	
	SignalBus.on_collectable_colleced.connect(on_collectable_collected)
	SignalBus.on_hit.connect(on_player_hit)


func on_collectable_collected(value : int) -> void:
	current_coins_collected += value
	GlobalStatContainer.add_coin(current_coins_collected)
	SignalBus.emit_on_coin_counter_updated(current_coins_collected)


func on_player_hit(value : int) -> void:
	current_coins_collected -= value
	
	GlobalStatContainer.remove_coins(value)
	
	if current_coins_collected <= 0:
		current_coins_collected = 0
	
	SignalBus.emit_on_coin_counter_updated(current_coins_collected)
