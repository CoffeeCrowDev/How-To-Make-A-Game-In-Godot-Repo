extends Node

signal on_collectable_colleced(value : int)
signal on_coin_counter_updated(value : int)
signal on_player_ready(player : PlayerEntity)
signal on_hit(value : int)
signal on_enemy_death
signal on_enemy_fled
signal on_game_state_manager_ready(GSM : GameStateManager)
signal on_player_entered_dead_zone
signal on_upgrade_purchased(upgrade : BaseUpgrade)
signal on_level_changed


func emit_on_level_changed() -> void:
	on_level_changed.emit()


func emit_on_upgrade_purchased(upgrade : BaseUpgrade) -> void:
	on_upgrade_purchased.emit(upgrade)


func emit_on_player_entered_dead_zone() -> void:
	on_player_entered_dead_zone.emit()


func emit_on_game_state_manager_ready(GSM : GameStateManager) -> void:
	on_game_state_manager_ready.emit(GSM)


func emit_on_enemy_fled() -> void:
	on_enemy_fled.emit()


func emit_on_enemy_death() -> void:
	on_enemy_death.emit()


func emit_on_hit(value : int) -> void:
	on_hit.emit(value)


func emit_on_player_ready(player : PlayerEntity) -> void:
	on_player_ready.emit(player)


func emit_on_coin_counter_updated(value : int) -> void:
	on_coin_counter_updated.emit(value)


func emit_on_collectable_collected(value : int) -> void:
	on_collectable_colleced.emit(value)
