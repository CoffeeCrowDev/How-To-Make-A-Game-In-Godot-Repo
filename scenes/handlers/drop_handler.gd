class_name DropHandler
extends Node2D

@onready var droppable_item : PackedScene = preload("res://scenes/collectables/base_coin.tscn")

var current_coin_count : int = 0


func _ready():
	current_coin_count = 0


func add_coin(value : int) -> void:
	current_coin_count += value
	print(current_coin_count)


func drop_coin() -> void:
	if current_coin_count <= 0:
		return
	
	var entity_container = NodeExtensions.get_entity_container()
	
	if entity_container == null:
		return
	
	var new_coin_scene = droppable_item.instantiate()
	
	var parent : Node2D = get_parent()
	
	var parent_pos = parent.global_position
	
	
	entity_container.call_deferred("add_child", new_coin_scene)
	
	new_coin_scene.position = parent_pos
	
