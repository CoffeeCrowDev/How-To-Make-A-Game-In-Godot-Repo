class_name GameStateManager
extends Node

@onready var state_timer = $StateTimer as Timer

@export var upgrade_menu_scene : PackedScene = null

@export var level_1 : PackedScene = null
@export var level_2 : PackedScene = null


var upgrade_menu_exists : bool = false
var level_exists : bool = false

enum {
	ActiveState,
	UpgradeState,
}

var current_state = ActiveState

func _ready():
	state_timer.timeout.connect(on_active_state_end)
	SignalBus.emit_on_game_state_manager_ready(self)
	load_level()


func _process(delta):
	match current_state:
		ActiveState:
			get_tree().paused = false
		
		UpgradeState:
			run_upgrade_state()


func load_level() -> void:
	var level_container : Node2D = NodeExtensions.get_level_container()
	
	if level_container == null:
		return
	
	if level_container.get_child(0) != null:
		level_container.get_child(0).queue_free()
	
	SignalBus.emit_on_level_changed()
	
	if level_exists != true:
		var new_level = level_1.instantiate()
		level_container.add_child(new_level)
		level_exists = true
		return
	
	if level_exists == true:
		var new_level = level_2.instantiate()
		level_container.add_child(new_level)
		level_exists = false
		return
 
func run_upgrade_state() -> void:
	if get_tree().paused == false:
		get_tree().paused = true
	
	if upgrade_menu_exists == true:
		return
	
	var new_upgrade_menu = upgrade_menu_scene.instantiate() as UpgradeMenu
	var ui_container = NodeExtensions.get_ui_container()
	
	if ui_container == null:
		return
	
	ui_container.add_child(new_upgrade_menu)
	new_upgrade_menu.exit_button_pressed.connect(on_upgrade_state_end)
	upgrade_menu_exists = true



func on_active_state_end() -> void:
	current_state = UpgradeState


func on_upgrade_state_end() -> void:
	upgrade_menu_exists = false
	current_state = ActiveState
	load_level()
