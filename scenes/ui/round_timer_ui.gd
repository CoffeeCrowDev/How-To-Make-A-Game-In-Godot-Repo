class_name RoundTimer_UI
extends Control

@onready var timer_label = $TimerLabel as Label

var round_timer : Timer = null

func _ready():
	SignalBus.on_game_state_manager_ready.connect(on_game_state_manager_ready)


func _process(delta):
	if round_timer == null:
		return
	
	set_timer_label_text()


func set_timer_label_text() -> void:
	timer_label.text = str(roundf(round_timer.time_left))


func on_game_state_manager_ready(GSM : GameStateManager) -> void:
	round_timer = GSM.state_timer
