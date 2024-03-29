class_name DEBUG_UI
extends Control

@onready var debug_lbl = $DebugLbl as Label

var is_debug_enabled : bool = false
var player_entity : PlayerEntity = null

func _ready():
	if OS.is_debug_build() != true:
		is_debug_enabled = false
		visible = false
		return
	else:
		SignalBus.on_player_ready.connect(on_player_ready)
		is_debug_enabled = true
		return


func _process(_delta):
	handle_debug_stats()


func handle_debug_stats() -> void:
	if is_debug_enabled == false:
		return
	
	toggle_debug_ui()
	set_debug_text()


func toggle_debug_ui() -> void:
	if Input.is_action_just_pressed("DEBUG"):
		if visible == true:
			visible = false
		else:
			print("DEBUG_ENABLED")
			visible = true


func set_debug_text() -> void:
	if player_entity == null:
		return
	
	debug_lbl.text = "World Gravity : {0}\nPlayer State : {1}\nPlayer Health : {2}\
		\nPlayer Velo_X : {3}\nPlayer Velo_Y : {4}".format([
		
		player_entity.gravity_handler.GRAVITY,
		player_entity.player_state_machine.current_state.name,
		player_entity.health_handler.current_health,
		roundf(player_entity.velocity.x),
		player_entity.velocity.y,
		
	])



func on_player_ready(entity : PlayerEntity) -> void:
	player_entity = entity
