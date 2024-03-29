class_name UpgradeOption
extends Control


@export var base_null_upgrade : BaseUpgrade = null

@onready var upgrade_label = $Panel/MarginContainer/VBoxContainer/UpgradeLabel as Label
@onready var stats_label = $Panel/MarginContainer/VBoxContainer/StatsLabel as Label
@onready var desc_label = $Panel/MarginContainer/VBoxContainer/ScrollContainer/DescLabel as Label
@onready var button = $Panel/MarginContainer/VBoxContainer/Button as Button

var stored_upgrade : BaseUpgrade = null
signal on_upgrade_selected

func _ready():
	button.button_down.connect(on_upgrade_purchased)
	set_upgrade_option(null)


func set_upgrade_option(upgrade : BaseUpgrade) -> void:
	if upgrade == null:
		upgrade_label.text = base_null_upgrade.upgrade_name
		desc_label.text = base_null_upgrade.upgrade_description
		button.text = "Buy(" + str(base_null_upgrade.upgrade_cost) + ")"
	else:
		upgrade_label.text = upgrade.upgrade_name
		desc_label.text = upgrade.upgrade_description
		button.text = "Buy(" + str(upgrade.upgrade_cost) + ")"
		stored_upgrade = upgrade


func on_upgrade_purchased() -> void:
	on_upgrade_selected.emit()
	SignalBus.emit_on_upgrade_purchased(stored_upgrade)
