extends Node

var currently_held_coins : int = 3
var currently_selected_upgrade : BaseUpgrade = null


func _ready():
	SignalBus.on_upgrade_purchased.connect(on_upgrade_selected)


func get_current_coins() -> int:
	return currently_held_coins


func add_coin(value : int) -> void:
	currently_held_coins = value


func remove_coins(value : int) -> void:
	currently_held_coins -= value


func on_upgrade_selected(upgrade : BaseUpgrade) -> void:
	currently_selected_upgrade = upgrade
