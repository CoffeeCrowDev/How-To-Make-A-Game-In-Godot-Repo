class_name UpgradeMenu
extends Control

@onready var button = $MarginContainer/VBoxContainer/Button as Button

@export var upgrade_option_array : Array[UpgradeOption] = []

@export var available_upgrade : Array[BaseUpgrade] = []


signal exit_button_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	button.button_down.connect(on_exit_button_down)
	select_random_upgrade()
	connect_upgrade_options_signals()


func connect_upgrade_options_signals() -> void:
	for i in upgrade_option_array:
		i.on_upgrade_selected.connect(on_exit_button_down)


func select_random_upgrade() -> void:
	var upgrade_name_list : Array[String] = []
	for u_name in DirAccess.get_files_at("res://scenes/resources/upgrade_folder/upgrades/"):
		upgrade_name_list.append(u_name)
	
	for u_name in upgrade_name_list.size():
		available_upgrade.append(load("res://scenes/resources/upgrade_folder/upgrades/" + upgrade_name_list[u_name]))
	
	for upgrade in upgrade_option_array:
		available_upgrade.shuffle()
		upgrade.set_upgrade_option(available_upgrade.pick_random())
	
	print(upgrade_name_list)


func on_exit_button_down() -> void:
	exit_button_pressed.emit()
	queue_free()
