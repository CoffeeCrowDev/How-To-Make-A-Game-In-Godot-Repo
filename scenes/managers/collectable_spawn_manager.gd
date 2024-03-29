class_name CollectableSpawnManager
extends Node

@export var timer_min : float = 0.1
@export var timer_max : float = 4.0
@export var spawn_points : Array[Marker2D] = []
@export var coin_entity_scene : PackedScene = null

@onready var spawn_timer = $SpawnTimer as Timer


func _ready():
	spawn_timer.timeout.connect(handle_collectable_spawns)
	spawn_timer.start()



func handle_collectable_spawns() -> void:
	var new_coin : BaseCoin = coin_entity_scene.instantiate()
	var entity_container : Node2D = NodeExtensions.get_entity_container()
	
	if entity_container == null:
		return
	
	spawn_points.shuffle()
	var chosen_spawn_point : Marker2D = spawn_points.pick_random()
	
	entity_container.add_child(new_coin)
	new_coin.position = chosen_spawn_point.position
	
	spawn_timer.start(NodeExtensions.get_random_time(timer_min, timer_max))
