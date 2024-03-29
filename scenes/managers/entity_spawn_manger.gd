class_name EntitySpawnManager
extends Node


#region Player Region
@export_category("Player")
@export var player_spawn_point : Marker2D = null
@export var player_packed_scene : PackedScene = null

var player_spawned : bool = false
#endregion


#region Enemy Region
@export_category("Enemy")
@export var enemy_spawn_timer_min : int = 0.1
@export var enemy_spawn_timer_max : int = 4.0
@export var enemy_spawn_points : Array[Marker2D] = []
@export var enemy_packed_scene : PackedScene = null
@export var max_enemies_alive : int = 0

@onready var enemy_spawn_timer = $EnemySpawnTimer as Timer



var enemy_count : int = 0
#endregion


func _ready():
	SignalBus.on_player_entered_dead_zone.connect(on_player_respawn)
	SignalBus.on_enemy_death.connect(on_enemy_death)
	SignalBus.on_enemy_fled.connect(on_enemy_fled)
	enemy_spawn_timer.timeout.connect(on_enemy_spawn)



func _process(delta):
	
	if player_spawned == false:
		spawn_player()
	else:
		pass


func spawn_player() -> void:
	var new_player : PlayerEntity = player_packed_scene.instantiate()
	var entity_container : Node2D = NodeExtensions.get_entity_container()
	
	if entity_container == null:
		return
	
	entity_container.add_child(new_player)
	new_player.position = player_spawn_point.position
	
	player_spawned = true


func on_enemy_spawn() -> void:
	if enemy_count >= max_enemies_alive:
		return
	
	var new_enemy : PatrollerEnemy = enemy_packed_scene.instantiate()
	var entity_container : Node2D = NodeExtensions.get_entity_container()
	
	if entity_container == null:
		return
	
	enemy_spawn_points.shuffle()
	var chosen_enemy_spawn_point : Marker2D = enemy_spawn_points.pick_random()
	
	entity_container.add_child(new_enemy)
	new_enemy.position = chosen_enemy_spawn_point.position
	
	enemy_spawn_timer.start(NodeExtensions.get_random_time(enemy_spawn_timer_min,enemy_spawn_timer_max))
	new_enemy.starting_location = chosen_enemy_spawn_point.position
	
	enemy_count += 1


func on_enemy_death() -> void:
	enemy_count -= 1


func on_enemy_fled() -> void:
	enemy_count -= 1


func on_player_respawn() -> void:
	player_spawned = false
