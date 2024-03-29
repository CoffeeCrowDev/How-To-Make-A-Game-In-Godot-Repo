class_name CoinCounter_UI
extends Control

@onready var coin_counter_number = $HBoxContainer/CoinCounterNumber as Label


func _ready():
	set_coin_counter_label(GlobalStatContainer.get_current_coins())
	SignalBus.on_coin_counter_updated.connect(set_coin_counter_label)


func set_coin_counter_label(value : int) -> void:
	coin_counter_number.text = str(value)
